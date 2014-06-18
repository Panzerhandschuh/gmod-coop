HOOKS["InitPostEntity"] = function()
	ents.FindByName("next_areadoor03")[1]:Remove()
	ents.FindByName("next_areadoor01")[1]:Remove()
	ents.FindByName("next_areadoor02")[1]:Remove()
end