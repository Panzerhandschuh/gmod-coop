-- Adjust spawners to be less boring
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 0.75)
		elseif (k == "SpawnFrequency") then
			return v * 0.75
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

-- Fix npc not being registered as killed by a npc_maker
HOOKS["EntityTakeDamage"] = function(target, dmg)
	if (target:GetClass() == "npc_manhack") then
		if (dmg:GetInflictor() == target) then
			dmg:SetDamage(0)
		end
	end

	return dmg
end