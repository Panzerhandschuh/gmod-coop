HOOKS["InitPostEntity"] = function()
	ents.FindByName("painful_gun")[1]:Remove()
	ents.FindByName("trigger_gun")[1]:Remove()
end