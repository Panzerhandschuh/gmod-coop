HOOKS["InitPostEntity"] = function()
	ents.FindByName("npc_guard")[1]:SetKeyValue("damagefilter", "")

	for k,v in pairs(ents.FindByName("bouton1")) do
		v:Fire("AddOutput","OnPressed portal,Enable,,0.10,-1",0)
		v:Fire("AddOutput","OnPressed make_garg,Spawn,,4,-1",0)
		v:Fire("AddOutput","OnPressed portal,Disable,,5.10,-1",0)
	end
end