HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("prop_door_rotating")) do
		if (v:GetPos() == Vector(-624, 96, -381)) then
			v:Remove()
		end
	end
end