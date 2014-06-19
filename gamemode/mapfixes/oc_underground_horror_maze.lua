HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("start_relay_trigger")) do
		v:Remove()
	end
end