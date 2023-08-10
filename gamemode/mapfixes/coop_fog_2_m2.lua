HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 2)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		elseif (k == "SpawnFrequency") then
			return math.Round(v * 0.5)
		end
	end

	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "fog_2_m1") then
		e:Remove()
	end
end

-- HOOKS["EntityTakeDamage"] = function(e,dmg)
-- 	if (e:GetClass() == "npc_citizen") then
-- 		dmg:SetDamage(0)
-- 	end
	
-- 	return dmg
-- end