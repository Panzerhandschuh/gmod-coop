HOOKS["InitPostEntity"] = function()
	local coopTrigger = ents.FindByName("trial_a_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.match(v, "ClearCheckPoint")) then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end