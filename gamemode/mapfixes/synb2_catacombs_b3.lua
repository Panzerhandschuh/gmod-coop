HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("m2")) do
		v:Fire("AddOutput","OnHitMax sas100,Open,,5,-1",0)
		v:Fire("AddOutput","OnHitMax sas101,Open,,5,-1",0)
	end

	for k,v in pairs(ents.FindByName("count_gu1")) do
		v:Fire("AddOutput","OnHitMax relay2,Trigger,,5,-1",0)
	end
end