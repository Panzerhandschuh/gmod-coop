HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("trial_b2_pretrigger")[1]
	ent:Fire("AddOutput","OnTrigger trial_b_trigger,Kill,,0,1",0)
	
	local coopTrigger = ents.FindByName("trial_d_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
	coopTrigger = ents.FindByName("finale_coop")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
end