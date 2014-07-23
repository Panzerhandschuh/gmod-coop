HOOKS["InitPostEntity"] = function(e,k,v)
	ents.FindByName("teleport_fix_trigger_1")[1]:Remove()
	ents.FindByName("teleport_fix_trigger_2")[1]:Remove()
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("cg_shutoff_button")) do
		v:Fire("AddOutput","OnOpen fakegameender,EndGame,,15,-1",0)
	end
end