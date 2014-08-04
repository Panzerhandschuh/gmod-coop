HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("trigger_once")[1]
	ent:Fire("AddOutput","OnStartTouch relay_3,Trigger,,10,1",0)
end