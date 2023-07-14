-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_smg1")
		ply:Give("weapon_ar2")
		ply:Give("weapon_shotgun")

		ply:GiveAmmo(135, "smg1", true)
		ply:GiveAmmo(12, "buckshot", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	-- Remove crashing entities
	for k,v in pairs(ents.FindByName("Combine_ship")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByName("HeavyHeli1")) do
		v:Remove()
	end

	-- End game after special helicopter is defeated
	for k,v in pairs(ents.FindByName("Simple_heli1")) do
		v:Fire("AddOutput","OnDeath Objectives_Set_10,Trigger,,0,-1",0)
		v:Fire("AddOutput","OnDeath muziekend,PlaySound,,5,-1",0)
		v:Fire("AddOutput","OnDeath Objectives_Set_11,Trigger,,20,-1",0)
		v:Fire("AddOutput","OnDeath Objectives_Set_12,Trigger,,28,-1",0)
		v:Fire("AddOutput","OnDeath gameender,EndGame,,35,-1",0)
	end
end
