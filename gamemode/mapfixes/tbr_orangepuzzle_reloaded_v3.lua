HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("lvlCounter")[1]
	counter.requiredPuzzles = 8
	counter:SetKeyValue("max", "8")
end