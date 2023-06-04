HOOKS["InitPostEntity"] = function()
	ents.FindByName("counter2")[1]:SetKeyValue("max", "150")
end