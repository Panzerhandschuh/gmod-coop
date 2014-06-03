HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		v:Fire("Unlock","",0)
	end
end