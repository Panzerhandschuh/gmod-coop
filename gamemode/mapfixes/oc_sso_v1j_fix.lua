HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "env_sprite" && k == "model" && v == "sprites/exit1.spr") then
		return "sprites/strider_blackball.spr"
	end
end

HOOKS["InitPostEntity"] = function()
	local eq1 = ents.FindByName("eq_spawnLv1")[1]
	eq1:SetKeyValue("item_ammo_357_large", "1", 0)
	eq1:SetKeyValue("item_ammo_crossbow", "10", 0)
	eq1:SetKeyValue("item_box_buckshot", "4", 0)
	
	ents.FindByName("cnt_z01_003A")[1]:Fire("add", "2")
	ents.FindByName("mak_z01_npc_014A")[1]:Fire("AddOutput","OnAllSpawnedDead cnt_z01_007A,Add,1,,-1",0)
	ents.FindByName("mak_z01_npc_015A")[1]:Fire("AddOutput","OnAllSpawnedDead cnt_z01_007A,Add,1,,-1",0)
end