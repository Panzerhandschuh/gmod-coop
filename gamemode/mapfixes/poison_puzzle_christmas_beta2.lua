HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("MainCounter")[1]
	counter.requiredPuzzles = 6
	counter:SetKeyValue("max", "6")
end