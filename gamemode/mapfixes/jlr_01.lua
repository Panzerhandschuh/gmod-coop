HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("point_viewcontrol")) do
		v:Remove()
	end
end