HOOKS["InitPostEntity"] = function()
	ents.FindByClass("trigger_changelevel")[1]:Remove()
	ents.FindByName("lift_top_door")[1]:Remove()
end