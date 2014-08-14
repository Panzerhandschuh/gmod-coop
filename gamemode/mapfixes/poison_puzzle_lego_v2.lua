HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("lvlCounter")[1]
	counter.requiredPuzzles = 7
	counter:SetKeyValue("max", "7")
end