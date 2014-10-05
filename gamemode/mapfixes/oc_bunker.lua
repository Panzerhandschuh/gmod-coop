HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("ZOMBIE_SPAWN1")[1]
	ent:SetKeyValue("MaxNPCCount", "35")
	
	for k,v in pairs(ents.FindByName("security_camera")) do
		v:SetKeyValue("minhealthdmg", "0")
	end
end

-- Adjust spawners to be less boring
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "SpawnFrequency") then
			return v * 0.7
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end