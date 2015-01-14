HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "env_sprite" && k == "model" && v == "sprites/exit1.spr") then
		return "sprites/strider_blackball.spr"
	end
end

HOOKS["InitPostEntity"] = function()
	local eq1 = ents.FindByClass("eq_spawnLv1")[1]
	eq1:SetKeyValue("item_ammo_357_large", "1", 0)
	eq1:SetKeyValue("item_ammo_crossbow", "10", 0)
	eq1:SetKeyValue("item_box_buckshot", "4", 0)
end