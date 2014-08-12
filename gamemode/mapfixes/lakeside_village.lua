HOOKS["InitPostEntity"] = function()
	ents.FindByName("ff_door1")[1]:Remove()
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("final_trigger")) do
		v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,20,-1",0)
	end
end