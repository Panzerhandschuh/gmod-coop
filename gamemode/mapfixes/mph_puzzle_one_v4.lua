HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("final_door_counter")[1]
	counter.requiredPuzzles = 7
	counter:SetKeyValue("max", "7")
end