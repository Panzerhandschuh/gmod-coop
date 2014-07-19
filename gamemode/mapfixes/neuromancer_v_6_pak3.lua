HOOKS["InitPostEntity"] = function(e,k,v)
	ents.FindByName("teleport_fix_trigger_1")[1]:Remove()
	ents.FindByName("teleport_fix_trigger_2")[1]:Remove()
end