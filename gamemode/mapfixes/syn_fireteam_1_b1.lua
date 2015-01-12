-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_rpg")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(30, "buckshot", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:GetClass() == "prop_vehicle_jeep") then
		if(k == "vehiclescript") then
			e.script = v
		end
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("Elevator_1_Toggle_Top")[1]:Remove()
	ents.FindByName("Elevator_1_Toggle_Bottom")[1]:Remove()
	ents.FindByName("Elevator_1")[1]:SetKeyValue("speed", "60")

	for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		v:SetSolid(SOLID_NONE)
		
		local s = ents.Create("vehicle_spawner")
		s:SetName(v:GetName())
		s:SetPos(v:GetPos())
		s:SetAngles(v:GetAngles())
		s.jmodel = v:GetModel()
		s.jscript = v.script
		s.jeep = true
		s:Spawn()
		
		v:Remove()
	end
end