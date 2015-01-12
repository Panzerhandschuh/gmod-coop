HOOKS["InitPostEntity"] = function()
	local coopTrigger = ents.FindByName("trial_a_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
end