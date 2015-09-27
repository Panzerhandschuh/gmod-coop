HOOKS["InitPostEntity"] = function()
	ents.FindByName("breakmetaldoor")[1]:Remove()
	
	local heli = ents.FindByClass("npc_helicopter")[1]
	heli:Fire("AddOutput","OnDeath end_counter,Add,10,40,-1", 0)
end