HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("m2")) do
		v:Fire("AddOutput","OnHitMax sas100,Open,,5,-1",0)
		v:Fire("AddOutput","OnHitMax sas101,Open,,5,-1",0)
	end

	for k,v in pairs(ents.FindByName("sas40")) do
		v:Fire("AddOutput","OnOpen relay2,Trigger,,80,-1",0)
	end

	ents.FindByName("trig_p1")[1]:Remove()
end