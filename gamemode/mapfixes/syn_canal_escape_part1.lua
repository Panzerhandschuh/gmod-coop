HOOKS["InitPostEntity"] = function()
	ents.FindByName("zombiesmashsewer_wood")[1]:Remove()
	
	local ent = ents.FindByName("roof_solider_templatemaker")[1]
	ent:SetKeyValue("MaxNPCCount", "15")
end