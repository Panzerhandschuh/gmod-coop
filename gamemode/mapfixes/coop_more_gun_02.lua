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
	ents.FindByName("as1count")[1]:Remove()
	ents.FindByName("as2count")[1]:Remove()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(1720, 0, 544)) then
			v:Fire("AddOutput","OnStartTouch as1,ForceSpawn,,10,-1",0)
			v:Fire("AddOutput","OnStartTouch as2,ForceSpawn,,10,-1",0)
			v:Fire("AddOutput","OnStartTouch as1,ForceSpawn,,20,-1",0)
			v:Fire("AddOutput","OnStartTouch as2,ForceSpawn,,20,-1",0)
			v:Fire("AddOutput","OnStartTouch as1,ForceSpawn,,30,-1",0)
			v:Fire("AddOutput","OnStartTouch as2,ForceSpawn,,30,-1",0)
		end
	end
end