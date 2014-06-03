HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		v:Fire("Unlock","",0)
	end
	for k,v in pairs(ents.FindByName("gunship01_path8")) do
		v:SetKeyValue("target","")
		v:Spawn()
	end
	for k,v in pairs(ents.FindByName("gunship02_path10")) do
		v:SetKeyValue("target","")
		v:Spawn()
	end
	timer.Simple(1,function() --ensures its properly gone
		for k,v in pairs(ents.FindByName("combinemaker08")) do
			v:Remove()
		end
	end)
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 43 && k == "target") then
		return ""
	end
	if(e:EntIndex() == 548 && k == "target") then
		return ""
	end
end
