HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	ents.FindByClass("npc_helicopter")[1]:Fire("AddOutput","OnDeath fakegameender,EndGame,,10,-1",0)
end