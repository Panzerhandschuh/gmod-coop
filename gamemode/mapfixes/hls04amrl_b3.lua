-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple(0.1, function()
		if (ply._Class == "mp_samus") then
			ply:StripWeapon("weapon_physcannon")
		else
			ply:StripWeapons()
		end

		ply:Give("weapon_crowbar")
		ply:Give("weapon_pistol")
		ply:Give("weapon_frag")
		ply:Give("weapon_shotgun")
	
		ply:GiveAmmo(20, "buckshot", true)
	end)
end