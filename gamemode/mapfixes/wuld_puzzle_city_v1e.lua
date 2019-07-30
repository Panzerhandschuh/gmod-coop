HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("final_counter")[1]
	counter.requiredPuzzles = 6
	counter:SetKeyValue("max", "6")
end