-- Adjust spawners to be less annoying
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "MaxNPCCount") then
			if (v >= 40)
				return math.Round(v * 0.5)
			elseif (v >= 20)
				return math.Round(v * 0.75)
			else
				return v
			end
		end
	end
end