HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("lvlCounter")[1]
	counter.requiredPuzzles = 6
	counter:SetKeyValue("max", "6")
end