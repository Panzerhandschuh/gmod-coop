HOOKS["PlayerCanPickupWeapon"] = function(ply, wep)
	-- Fixes weapon pickup output not firing for replacement weapons
	if (wep.hasPickupOutput) then
		wep:Input("FireUser1")
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	-- Add pickup output
	if (string.StartsWith(e:GetClass(), "weapon_") && k == "OnPlayerPickup") then
		e:SetKeyValue("OnUser1", v)
		e.hasPickupOutput = true
		return ""
	end

	if(k == "OnPass" && v == "startcam_2,Enable,,0.5,1") then
		return "startcam_1,Disable,,0.5,1"
	end
end

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

	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if (v:GetPos() == Vector(-6, -2872, 563.52)) then
			v:Remove()
		elseif (v:GetPos() == Vector(-6, -3554, 563.522)) then
			v:SetKeyValue("health", "99999999")
			v:SetKeyValue("spawnflags", "1")
		end
	end

	for k,v in pairs(ents.FindByClass("env_sprite")) do
		if (v:GetPos() == Vector(-6, -3633, 568)) then
			v:Remove()
		end
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