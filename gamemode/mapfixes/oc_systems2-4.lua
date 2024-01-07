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
	-- ents.FindByName("Npc_teleport_maker_manhack1")[1]:Remove()
	-- ents.FindByName("Npc_teleport_maker_manhack2")[1]:Remove()

	ents.FindByName("Simple_heli1")[1]:Remove()
	ents.FindByName("HeavyHeli1")[1]:Remove()
	ents.FindByName("Combine_ship")[1]:Remove()

	-- End game after special helicopter is defeated
	for k,v in pairs(ents.FindByName("CombineGunship2")) do
		v:Fire("AddOutput","OnDeath Objectives_Set_10,Trigger,,0,-1",0)
		v:Fire("AddOutput","OnDeath muziekend,PlaySound,,5,-1",0)
		v:Fire("AddOutput","OnDeath Objectives_Set_11,Trigger,,20,-1",0)
		v:Fire("AddOutput","OnDeath Objectives_Set_12,Trigger,,28,-1",0)
		v:Fire("AddOutput","OnDeath gameender,EndGame,,35,-1",0)
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.find(e:GetClass(), "npc_")) then
		if (k == "model") then
			return ""
		elseif (k == "gibmodel0") then
			return ""
		elseif (k == "gibmodel1") then
			return ""
		elseif (k == "gibmodel2") then
			return ""
		end
	end
end
