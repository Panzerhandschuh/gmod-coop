HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("trial_b2_pretrigger")[1]
	ent:Fire("AddOutput","OnTrigger trial_b_trigger,Kill,,0,1",0)
end