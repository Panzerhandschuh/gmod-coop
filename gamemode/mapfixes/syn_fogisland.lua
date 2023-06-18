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

	for k,v in pairs(ents.FindByName("gonarchreleasebutton")) do
		v:Fire("AddOutput","OnPressed house2_basementdoor01,Unlock,,0,-1",0)
		v:Fire("AddOutput","OnPressed house2_basementdoor01,Open,,1,-1",0)
		v:Fire("AddOutput","OnPressed pzombie01_trigger,Enable,,0,-1",0)
	end

	for k,v in pairs(ents.FindByName("house2_basementdoor01_poleclip")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByName("house2_basementdoor01_clip")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByName("h2basement_counter")) do
		v:SetKeyValue("max", "20")
	end

	for k,v in pairs(ents.FindByName("elite_counter")) do
		v:SetKeyValue("max", "12")
	end

	for k,v in pairs(ents.FindByName("Strider01_timertofire")) do
		v:SetKeyValue("RefireTime", "32")
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 43 && k == "target") then
		return ""
	end
	if(e:EntIndex() == 548 && k == "target") then
		return ""
	end
end
