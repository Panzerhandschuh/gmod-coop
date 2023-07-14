HOOKS["InitPostEntity"] = function()
	ents.FindByName("roof_break")[1]:Fire("Break")
end