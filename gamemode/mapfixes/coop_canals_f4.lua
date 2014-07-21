-- Adjust spawners to be less boring
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 0.75)
		elseif (k == "SpawnFrequency") then
			return math.Round(v * 0.75)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end