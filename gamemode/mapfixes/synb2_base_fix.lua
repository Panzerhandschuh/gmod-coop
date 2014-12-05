HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 518 && k == "target") then
		return ""
	end
	if(e:EntIndex() == 520 && k == "target") then
		return ""
	end
	--if(e:GetClass() == "npc_combinegunship" && k == "target") then
	--	if(v == "gun1_p2") then
	--		return "gun1_p3"
	--	elseif(v == "gun1_p1") then
	--		return "gun1_p4"
	--	end
	--end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("gun1_p4")[1]:Remove()
	ents.FindByName("gun1_p3")[1]:Remove()
	ents.FindByName("gun1_p2")[1]:Remove()
	ents.FindByName("gun1_p1")[1]:Remove()
	--ents.FindByName("gun1_p3")[1]:SetKeyValue("target","")
	--ents.FindByName("gun1_p4")[1]:SetKeyValue("target","")
end