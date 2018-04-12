HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("Final_Counter")[1]
	counter.requiredPuzzles = 5
	counter:SetKeyValue("max", "5")
end