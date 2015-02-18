HOOKS["InitPostEntity"] = function()
	local coopTrigger = ents.FindByName("trial_a_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
	coopTrigger = ents.FindByName("prelude_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
	
	ents.FindByName("prelude_stripper_shutdown")[1]:Remove()
end