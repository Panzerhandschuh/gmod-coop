-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
	timer.Simple( 0.1, function()
	ply:StripWeapons()
	ply:Give("weapon_crowbar_hl1")
	ply:Give("weapon_glock_hl1")
	ply:Give("weapon_handgrenade")
	ply:Give("weapon_shotgun_hl1")
	ply:Give("weapon_mp5_hl1")
	ply:Give("weapon_357_hl1")
	
	ply:GiveAmmo(20, "buckshot", true)
	ply:GiveAmmo(115, "smg1", true)
	ply:GiveAmmo(12, "357", true)
	
	end )
end

-- not sure if necessary but thought i'd see how it affects the trains
HOOKS["InitPostEntity"] = function()
	ents.FindByName("train")[1]:SetLagCompensated(true)
	ents.FindByName("z3train1")[1]:SetLagCompensated(true)
	ents.FindByName("z3train3")[1]:SetLagCompensated(true)
end