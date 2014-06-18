HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("weaponbox_weapons")) do
		v:SetName("")
	end
end