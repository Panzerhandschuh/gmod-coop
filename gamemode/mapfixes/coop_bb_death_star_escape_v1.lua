HOOKS["InitPostEntity"] = function()
	ents.FindByName("demo_ad")[1]:Remove()
	ents.FindByName("demo_text3")[1]:Remove()
	ents.FindByName("demo_end")[1]:Remove()
end

-- Adjust spawners to be less boring
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 0.8)
		elseif (k == "SpawnFrequency") then
			return v * 0.8
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 1.5)
		end
	end
end