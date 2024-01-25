-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
	timer.Simple( 0.1, function()
	ply:StripWeapons()
	ply:Give("weapon_crowbar_hl1")
	ply:Give("weapon_glock_hl1")
	ply:Give("weapon_handgrenade")
	ply:Give("weapon_shotgun_hl1")
	
	ply:GiveAmmo(20, "buckshot", true)
	
	end )
end