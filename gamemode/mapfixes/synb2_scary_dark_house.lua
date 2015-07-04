HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("br_y*")) do
		v:SetHealth(250)
	end
end