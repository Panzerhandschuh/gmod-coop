-- Adjust spawners to be more fun
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 2)
		elseif (k == "SpawnFrequency") then
			return v * 0.6
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 1.5)
		end
	end
	
	if (k == "OnBreak" && v == "rpg_player_block,Open,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end