HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("combinemaker09")) do
		v:Fire("AddOutput","OnAllSpawnedDead fakegameender,EndGame,,25,-1",0)
	end
	
	local spawner = ents.FindByName("manhackmaker01")[1]
	spawner:Fire("AddOutput","OnSpawnNPC blockdoor01,Open,,20,-1",0)
end