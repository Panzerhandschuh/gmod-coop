-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(30, "buckshot", true)
	end )
end