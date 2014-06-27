HOOKS["InitPostEntity"] = function()
	ents.FindByName("mpc_count")[1]:Fire("add", "2", 0)
end