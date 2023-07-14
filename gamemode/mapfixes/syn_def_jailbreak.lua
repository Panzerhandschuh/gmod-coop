HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("thecounter2")[1]
	counter:SetKeyValue("max", "35")
end
