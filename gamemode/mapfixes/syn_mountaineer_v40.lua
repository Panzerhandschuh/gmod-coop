HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "OnAllLiveChildrenDead") then
			if (string.find(v, "Trigger,,40,-1")) then
				return string.gsub(v, "40", "10")
			end
		end
	elseif (e:GetClass() == "npc_combinegunship") then
		if (k == "OnDeath") then
			if (v == "gunship_maker2,Spawn,,300,-1") then
				return string.gsub(v, "300", "100")
			end
		end
	end
end