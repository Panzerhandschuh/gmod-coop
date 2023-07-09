HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("final_zombie_assault_txt_2")) do
		if (v:GetPos() == Vector(-256, -2864, -880)) then
			v:SetKeyValue("message", "so it'll take about 5 minutes to get there.")
		end
	end
	
	for k,v in pairs(ents.FindByClass("npc_*")) do
		if (string.find(v:GetClass(), "maker")) then
			continue
		end

		v:SetKeyValue("model", "")
		v:SetKeyValue("gibmodel0", "")
		v:SetKeyValue("gibmodel1", "")
		v:SetKeyValue("gibmodel2", "")
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "final_zombie_assault_relay" && k == "OnTrigger") then
		local split = string.Split(v, ",")
		local val = tonumber(split[4]) / 2 -- Half the output delay
		return string.gsub(v, split[4], tostring(val))
	end

	if (e:GetClass() == "npc_template_maker") then
		if (k == "SpawnFrequency") then
			return math.Round(v * 0.5)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 4)
		end
	end
end