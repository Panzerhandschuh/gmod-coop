-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(16, "buckshot", true)
		ply:GiveAmmo(30, "ar2", true)
	end )
end