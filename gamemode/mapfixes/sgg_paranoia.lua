HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 4)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByClass("weapon_physgun")[1]:Remove()
end

HOOKS["EntityTakeDamage"] = function(e,dmg)
	if (e:GetClass() == "npc_citizen") then
		dmg:SetDamage(0)
	end
	
	return dmg
end