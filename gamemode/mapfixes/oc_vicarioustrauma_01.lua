HOOKS["InitPostEntity"] = function()
	ents.FindByClass("point_viewcontrol")[1]:Remove()
end