HOOKS["InitPostEntity"] = function()
	ents.FindByName("begin_relay")[1]:Fire("Trigger", "", 0)
end
