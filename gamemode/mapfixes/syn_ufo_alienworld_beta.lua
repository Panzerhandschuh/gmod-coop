HOOKS["InitPostEntity"] = function()
	ents.FindByClass("trigger_changelevel")[1]:Remove()
end