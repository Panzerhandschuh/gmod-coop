-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_ar2")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(60, "ar2", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "launch_button" && k == "OnPressed") then
		if (v == "Launch_countdown,StartTimer,180,0,-1") then -- Lazy if elses
			return "Launch_countdown,StartTimer,30,0,-1"
		elseif (v == "camera_escape,Enable,,180,-1") then
			return "camera_escape,Enable,,30,-1"
		elseif (v == "spaceship_train,SetSpeed,250,185,-1") then
			return "spaceship_train,SetSpeed,250,35,-1"
		elseif (v == "ship_particle,Start,,185,-1") then
			return "ship_particle,Start,,35,-1"
		elseif (v == "launch_physicsdebris,EnableMotion,,180,-1") then
			return "launch_physicsdebris,EnableMotion,,30,-1"
		elseif (v == "spaceship_takeoff_ambient,PlaySound,,180,-1") then
			return "spaceship_takeoff_ambient,PlaySound,,30,-1"
		elseif (v == "ship_door,Close,,180,-1") then
			return "ship_door,Close,,30,-1"
		end
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("playerteleport_trigger")[1]:Remove()

	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-4323, -2993, 156))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(2080, -2432, 160))
	cp:SetAngles(Angle(0,90,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	local e = ents.FindByName("areaportal4_trigger")[1]
	e:Fire("AddOutput","OnStartTouch fcp1,SetAsCP,,0,1",0)
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(2082.5, -2283.5, 188.88)) then
			v:Fire("AddOutput","OnTrigger fcp2,SetAsCP,,0,-1",0)
		end
	end
	
	ents.FindByName("hurt_combineshieldwall1")[1]:Remove()
	ents.FindByName("trigger_combineshieldwall1")[1]:Remove()
	ents.FindByName("clip_combineshieldwall1")[1]:Remove()
	ents.FindByName("brush_combineshieldwall1")[1]:Remove()
end