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
	ply:Give("weapon_tripmine")
--	ply:Give("weapon_satchel")
	ply:Give("weapon_crossbow_hl1")
	ply:Give("weapon_gauss")
--	ply:Give("weapon_snark")
--	ply:Give("weapon_hornetgun")
	ply:Give("weapon_rpg_hl1")
	
	ply:GiveAmmo(20, "buckshot", true)
	ply:GiveAmmo(115, "smg1", true)
	ply:GiveAmmo(12, "357", true)
	ply:GiveAmmo(4, "xbowbolt", true)
	
	end )
end

-- not sure if necessary, this is for all of the moving platforms you have to jump on in Lambda Complex
HOOKS["InitPostEntity"] = function()
	ents.FindByName("coop_teleport_rotator")[1]:SetLagCompensated(true)
end