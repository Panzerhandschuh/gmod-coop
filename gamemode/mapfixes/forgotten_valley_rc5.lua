HOOKS["InitPostEntity"] = function()
	ents.FindByName("fact_door")[1]:SetKeyValue("targetname", "")
	ents.FindByName("snd_church_block")[1]:SetKeyValue("targetname", "")
	ents.FindByName("block_church")[1]:SetKeyValue("targetname", "")
	ents.FindByName("ss_breakcdoor")[1]:SetKeyValue("m_fMoveTo", "4")
	ents.FindByName("ss_breakcdoor")[1]:Fire("AddOutput","OnCancelFailedSequence door_church,Break,,0,1",0)
end