HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("zombine2_spawner")[1]
	ent:SetKeyValue("SpawnFrequency", "1")
	ent:SetKeyValue("MaxNPCCount", "15")
	
	ent = ents.FindByName("fastzombie3_maker")[1]
	ent:SetKeyValue("SpawnFrequency", "1")
	ent:SetKeyValue("MaxNPCCount", "15")
end