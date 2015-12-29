-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_rpg")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(30, "buckshot", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	local s = ents.Create("vehicle_spawner")
	s:SetPos(Vector(-6400, -10368, 64.95))
	s:SetAngles(Angle(0, 270, 0))
	s.jmodel = "models/buggy.mdl"
	s.jscript = "scripts/vehicles/jeep_test.txt"
	s.jeep = true
	s:Spawn()
	
	ents.FindByName("Trigger_CL")[1]:Remove()
end