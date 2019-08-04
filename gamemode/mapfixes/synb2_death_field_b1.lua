HOOKS["InitPostEntity"] = function()
	ents.FindByName("npc_guard")[1]:SetKeyValue("damagefilter", "")
end