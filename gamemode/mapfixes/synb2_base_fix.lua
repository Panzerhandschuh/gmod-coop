HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 518 && k == "target") then
		return ""
	end
	if(e:EntIndex() == 520 && k == "target") then
		return ""
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("gun1_p3")) do
		v:SetKeyValue("target","")
		v:Spawn()
	end
	for k,v in pairs(ents.FindByName("gun1_p4")) do
		v:SetKeyValue("target","")
		v:Spawn()
	end
end