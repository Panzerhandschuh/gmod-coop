HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker" || e:GetClass() == "npc_hunter_maker") then
		if (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		elseif (k == "MaxNPCCount") then
			return math.Round(v * 0.5)
		end
	end

	if (e:GetName() == "mines_trip_trg_sec" && k == "OnStartTouch" && string.find(v, "top_deck_doors_trg_ent")) then
		return ""
	end
end