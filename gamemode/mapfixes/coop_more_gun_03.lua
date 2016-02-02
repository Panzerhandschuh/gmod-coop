HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_357")
		ply:Give("weapon_ar2")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_crossbow")

		ply:GiveAmmo(12, "357", true)
		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(60, "ar2", true)
		ply:GiveAmmo(30, "buckshot", true)
		ply:GiveAmmo(10, "xbowbolt", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	ents.FindByName("brainhealth")[1]:Fire("AddOutput","OnBreak fakegameender,EndGame,,15,-1",0)
end