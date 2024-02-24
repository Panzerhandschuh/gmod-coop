-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple(0.1, function()
		if (ply._Class == "mp_samus") then
			ply:StripWeapon("weapon_physcannon")
		else
			ply:StripWeapons()
		end
	end)
end