HOOKS["InitPostEntity"] = function()
	ents.FindByName("pesula_portal3")[1]:Remove()
	ents.FindByName("pesula_portal2")[1]:Remove()
	ents.FindByName("ff_door1")[1]:Remove()
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("final_trigger")) do
		v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,54,-1",0)
	end
end