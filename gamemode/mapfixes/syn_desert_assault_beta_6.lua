HOOKS["InitPostEntity"] = function()
	ents.FindByName("start_gate")[1]:Fire("Break")
end