HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.match(v, "ClearCheckPoint")) then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end