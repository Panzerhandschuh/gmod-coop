HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("info_player_start")) do
		v:Remove()
	end
	
	ents.FindByName("rebel_rebel_filter")[1]:Remove()
	for k,v in pairs(ents.FindByClass("filter_activator_team")) do
		v:Remove()
	end
end