HOOKS["InitPostEntity"] = function()
	ents.FindByName("init_equip")[1]:Remove()
	local equip = ents.Create("game_player_equip")
	equip:SetName("init_equip")
	equip:SetKeyValue("weapon_stunstick", "1")
	equip:SetKeyValue("weapon_smg1", "1")
	equip:SetKeyValue("weapon_pistol", "1")
	equip:SetKeyValue("item_ammo_smg1", "2")
	equip:SetKeyValue("weapon_physcannon", "1")
	equip:SetKeyValue("weapon_ar2", "1")
	equip:SetKeyValue("item_ammo_ar2", "1")
	equip:Spawn()
end