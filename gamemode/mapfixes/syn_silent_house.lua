HOOKS["InitPostEntity"] = function()
	ents.FindByName("count_1")[1]:SetKeyValue("max", "4")
	local timer = ents.FindByName("timer_att")[1]
	timer:SetKeyValue("LowerRandomBound", "360")
	timer:SetKeyValue("UpperRandomBound", "360")
end

HOOKS["EntityTakeDamage"] = function(e,dmg)
	if (e:GetClass() == "npc_alyx") then
		dmg:SetDamage(0)
	end
	
	return dmg
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "logic_timer" && k == "OnTimer" && v == "relay_norm,Trigger,,360,-1") then
		return string.gsub(v, "360", "300")
	elseif (e:GetClass() == "trigger_once" && k == "OnStartTouch") then
		if (v == "timer_att,Enable,,119.9,-1") then
			return string.gsub(v, "119.9", "59.9")
		elseif (v == "timer_att,FireTimer,,120,-1") then
			return string.gsub(v, "120", "60")
		end
	end

	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 6)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 3)
		end
	end
end