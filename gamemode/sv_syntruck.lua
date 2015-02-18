--copied from a local testing file cba to fix indenting, george.
	
	SYN_V = {}
	SYN_V.Truck = {}
	SYN_V.Truck.FrontSeats = {{Pos = Vector(22, 70, 46), Ang = Angle(0, 0, 0)}}
	SYN_V.Truck.BackSeats = {
		{Pos = Vector(-27, 0, 45), Ang = Angle(0, -90, 0)},
		{Pos = Vector(-27, -45, 45), Ang = Angle(0, -90, 0)},
		{Pos = Vector(-27, -90, 45), Ang = Angle(0, -90, 0)},
		{Pos = Vector(27, 0, 45), Ang = Angle(0, 90, 0)},
		{Pos = Vector(27, -45, 45), Ang = Angle(0, 90, 0)},
		{Pos = Vector(27, -90, 45), Ang = Angle(0, 90, 0)},
	}
	SYN_V.Truck.FrontExits = {
		Vector(-80, 80, 15),
		Vector(80, 80, 15)
	}
	
	SYN_V.Truck.BackExits = {Vector(0, -152, 15)}
	
	function SYN_V.CreateTruck(pos,ang,script)
		local truck = ents.Create("prop_vehicle_jeep")
		truck:SetPos(pos)
		truck:SetAngles(ang)
		truck:SetModel("models/vehicles/8seattruck.mdl")
		truck:SetKeyValue("vehiclescript",script)
		truck:Spawn()
		truck.synv = true
		truck.isfront = true
		truck.vtable = SYN_V.Truck
		SYN_V.CreateSeats(truck)
		return truck
	end
	
	function SYN_V.CreateASeat(vehicle,pos,ang,isfront)
		local sdb = list.Get("Vehicles")["Seat_Jeep"]
		local op = vehicle:GetPos()
		local oa = vehicle:GetAngles()
		local pos = op + (oa:Forward() * pos.x) + (oa:Right() * -pos.y) + (oa:Up() * pos.z)
	
		local seat = ents.Create("prop_vehicle_prisoner_pod")
		seat:SetModel(sdb.Model)
		seat:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
		seat:SetAngles(oa + ang)
		seat:SetPos(pos)
		seat:Spawn()
		seat:Activate()
		seat:SetParent(vehicle)
	
		seat:SetSolid(SOLID_NONE)
		seat:SetMoveType(MOVETYPE_NONE)
	
		if sdb.Members then table.Merge(seat, sdb.Members) end
		if sdb.KeyValues then
			for k, v in pairs(sdb.KeyValues) do
				seat:SetKeyValue(k, v)
			end
		end
		
		seat.isfront = isfront
		seat.synv = true
		table.insert(vehicle.seats, seat)
		seat:SetColor(Color(255, 255, 255, 0))
		seat:SetRenderMode(RENDERMODE_TRANSALPHA)
	end
	
	function SYN_V.CreateSeats(vehicle)
		vehicle.seats = {}
		local vtable = vehicle.vtable
		for k,v in pairs(vtable.FrontSeats) do
			SYN_V.CreateASeat(vehicle,v.Pos,v.Ang,true)
		end
		for k,v in pairs(vtable.BackSeats) do
			SYN_V.CreateASeat(vehicle,v.Pos,v.Ang,false)
		end
	end
	
	function SYN_V.PlayerEnteredVehicle(ply,vehicle,role)
		if(vehicle.synv && vehicle.seats) then
			ply:SetParent(nil)
			local a = vehicle:LookupAttachment("vehicle_passenger0_feet")
			local angp = vehicle:GetAttachment(a)
			ply:SetPos(angp.Pos+Vector(0,0,-8)+(angp.Ang:Forward()*-9))
			ply:SetParent(vehicle,a)
			ply:SetEyeAngles(Angle(0,vehicle:GetAngles().y,0))
			timer.Simple(0.01,function() vehicle.syndriver = true end)
		end
	end
	hook.Add("PlayerEnteredVehicle","SYN_V.PEV",SYN_V.PlayerEnteredVehicle)

	local c = Vector(-23.270752, -70.312988, 83.736328)
	
	local function mySetupVis(ply)
		local v = ply:GetVehicle()
		if(IsValid(v) && v.synv && v.seats) then
			local ang = v:GetAngles()
			local cor = c.x*ang:Forward()+c.y*ang:Right()+c.z*ang:Up()
			AddOriginToPVS(v:GetPos()+cor)
		end
	end
	hook.Add("SetupPlayerVisibility", "SYN_V.PVS", mySetupVis)
	
	hook.Add("PlayerLeaveVehicle","SYN_V.LEAVE",function(ply, v)
		ply.NextUse = CurTime()+1
		if(ply.leavepos) then
			ply:SetPos(ply.leavepos)
		end
		ply.leavepos = nil
		v.syndriver = false
	end)
	
	hook.Add("CanPlayerEnterVehicle", "SYN_V.CANENTER", function(v,ply)
		if(v.synv && v.seats && !ply.forced) then return false end
	end)
	
	hook.Add("CanExitVehicle", "SYN_V.CANLEAVE", function(v,ply)
		if(ply.NextUse > CurTime()) then return false end
		if(v.synv) then
			ply.leavepos = nil
			local et = {}
			if(v.isfront) then
				et = SYN_V.Truck.FrontExits
			else
				et = SYN_V.Truck.BackExits
			end
			local filter = {}
			local vp = v
			if(IsValid(v:GetParent()) && v:GetParent().seats) then
				vp = v:GetParent()
			end
			table.insert(filter,vp)
			for _,s in pairs(vp.seats) do
				table.insert(filter,s)
			end
			for k,v in pairs(player.GetAll()) do
				table.insert(filter,v)
			end
			local closestdistsq = nil
			local closestexit = nil
			for _,e in pairs(et) do
				e = vp:LocalToWorld(e)
				local dist = v:GetPos():DistToSqr(e)
				if(util.IsInWorld(e) && (!closestdistsq || dist < closestdistsq)) then
					local trace = {
						start = e,
						endpos = e+Vector(0,0,50),
						maxs = Vector(16,16,5),
						mins = Vector(-16,-16,0),
					}
					trace.filter = filter
					local tr = util.TraceHull(trace)
					if !tr.Hit then
						closestdistsq = dist
						closestexit = e
					end
				end
			end
			if !closestexit then return false end
			ply.leavepos = closestexit
		end
	end)
	
	hook.Add("PlayerUse", "CarEntrance", function(ply, ent)
		if(IsValid(ent) && ent.synv) then
			if(!ply.NextUse || ply.NextUse < CurTime()) then
				if(!ent.syndriver) then
					ply.forced = true
					ply:EnterVehicle(ent)
					ply.forced = false
				else
					local closestseat = nil
					local closestdistsq = nil
					for k,v in pairs(ent.seats) do
						local free = !IsValid(v:GetDriver())
						local dist = ply:GetPos():DistToSqr(v:GetPos())
						if(free && (!closestdistsq || dist < closestdistsq)) then
							closestdistsq = dist
							closestseat = v
						end
					end
					if(closestseat) then
						ply:EnterVehicle(closestseat)
					end
				end
				ply.NextUse = CurTime() + 1
			end
			return false
		end
	end)