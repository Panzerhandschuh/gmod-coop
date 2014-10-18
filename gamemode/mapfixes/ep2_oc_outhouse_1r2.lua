-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")

		ply:GiveAmmo(90, "smg1", true)
		ply:GiveAmmo(12, "buckshot", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	local r1 = ents.Create("weapon_frag")
	r1:SetPos(Vector(-6544, 224, -280))
	r1:SetAngles(Angle(0, 0, 0))
	r1.ei = 0.1
	r1.oPos = Vector(-6544, 224, -280)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()

	local r2 = ents.Create("weapon_frag")
	r2:SetPos(Vector(-6544, 224, -280))
	r2:SetAngles(Angle(0, 0, 0))
	r2.ei = 0.2
	r2.oPos = Vector(-6544, 224, -280)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
	
	local r3 = ents.Create("weapon_frag")
	r3:SetPos(Vector(-6544, 224, -280))
	r3:SetAngles(Angle(0, 0, 0))
	r3.ei = 0.3
	r3.oPos = Vector(-6544, 224, -280)
	r3.oAng = Angle(0, 0, 0)
	r3:Spawn()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(k == "OnPass" && v == "startcam_2,Enable,,0.5,1") then
		return "startcam_1,Disable,,0.5,1"
	end
end

HOOKS["OnEntityCreated"] = function(ent)
	if(ent:GetClass() == "item_custom") then --the ammo that spawns on the way back
		timer.Simple(0.1,function()
			if(ent:IsValid()) then
				if(!ent.ei) then
					ent.ei = ent:EntIndex()
					ent.oPos = ent:GetPos()
					ent.oAng = ent:GetAngles()
				end
			end
		end)
	end
end