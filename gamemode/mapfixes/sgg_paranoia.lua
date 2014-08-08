HOOKS["InitPostEntity"] = function()
	ents.FindByClass("weapon_physgun")[1]:Remove()
end