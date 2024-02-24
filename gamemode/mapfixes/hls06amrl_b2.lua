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
		ply:Give("weapon_smg1")
		ply:Give("weapon_357")
	
		ply:GiveAmmo(20, "buckshot", true)
		ply:GiveAmmo(115, "smg1", true)
		ply:GiveAmmo(12, "357", true)
	end)
end