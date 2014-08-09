HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnPressed" && v == "beginning_door,Lock,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end