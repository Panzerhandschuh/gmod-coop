HOOKS["InitPostEntity"] = function()
	timer.Simple(60, function()
		for k,v in pairs(ents.FindByName("pilon_act_1")) do
			v:Input("Trigger")
		end
	end)
end

HOOKS["EntityKeyValue"] = function(e, k, v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end
