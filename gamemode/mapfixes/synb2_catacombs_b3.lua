HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("advi1_rel1")[1]
	ent:Fire("AddOutput","OnTrigger sas10,Unlock,,10,1",0)
	
	ent = ents.FindByName("m2")[1]
	ent:Fire("AddOutput","OnHitMax sas100,Open,,10,1",0)
	ent:Fire("AddOutput","OnHitMax sas101,Open,,10,1",0)
end