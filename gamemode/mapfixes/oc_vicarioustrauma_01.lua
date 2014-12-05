HOOKS["InitPostEntity"] = function()
	ents.FindByClass("point_viewcontrol")[1]:Remove()
	ents.FindByName("morbut")[1]:Remove()
end