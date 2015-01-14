HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnPressed" && v == "beginning_door,Lock,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("razor_beam_door")[1]:SetKeyValue("wait", "5")
	local elevator = ents.FindByName("elevator")[1]
	elevator:Fire("AddOutput","OnNext elevator,StartBackward,,15,-1",0)
	elevator:Fire("AddOutput","OnStart elevator,StartForward,,15,-1",0)
end