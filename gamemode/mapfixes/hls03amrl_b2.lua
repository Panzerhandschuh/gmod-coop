-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
	timer.Simple( 0.1, function()
	ply:StripWeapons()
	ply:Give("weapon_crowbar_hl1")
	ply:Give("weapon_glock_hl1")
	ply:Give("weapon_handgrenade")
	
	end )
end