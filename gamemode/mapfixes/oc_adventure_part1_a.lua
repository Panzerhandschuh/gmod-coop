HOOKS["InitPostEntity"] = function()
	ents.FindByName("found_all_boots")[1]:Fire("Add", "2", 0)
	
	for k,v in pairs(ents.FindByClass("prop_physics")) do
		if (v:GetModel() == "models/props_c17/oildrum001_explosive.mdl") then
			v:Remove()
		end
	end
	
	for k,v in pairs(ents.FindByClass("prop_physics_respawnable")) do
		if (v:GetModel() == "models/props_c17/oildrum001_explosive.mdl") then
			v:Remove()
		end
	end
end