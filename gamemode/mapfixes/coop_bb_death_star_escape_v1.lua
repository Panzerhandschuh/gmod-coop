HOOKS["InitPostEntity"] = function()
	ents.FindByName("demo_ad")[1]:Remove()
	ents.FindByName("demo_text3")[1]:Remove()
	ents.FindByName("demo_end")[1]:Remove()
end