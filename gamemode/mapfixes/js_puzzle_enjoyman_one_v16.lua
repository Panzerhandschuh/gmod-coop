HOOKS["InitPostEntity"] = function()
	ents.FindByName("letter_e")[1]:Remove()
	
	local counter = ents.FindByName("enjoyman_counter")[1]
	counter.requiredPuzzles = 6
	counter:SetKeyValue("max", "6")
end