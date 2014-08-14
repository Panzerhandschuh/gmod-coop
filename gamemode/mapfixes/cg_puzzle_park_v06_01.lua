HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("math_counter_final")[1]
	counter.requiredPuzzles = 7
	counter:SetKeyValue("max", "7")
end