HOOKS["InitPostEntity"] = function()
	ents.FindByName("big_citadel_door1")[1]:Remove()
	ents.FindByName("clip_combineshieldwall3")[1]:Remove()
	ents.FindByName("clip_combineshieldwall4")[1]:Remove()
	ents.FindByName("brush_combineshieldwall3")[1]:Remove()
	ents.FindByName("brush_combineshieldwall4")[1]:Remove()
end