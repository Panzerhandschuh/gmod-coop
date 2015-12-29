HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnPressed" && v == "beginning_door,Lock,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end

HOOKS["InitPostEntity"] = function()
	local beamDoor = ents.FindByName("razor_beam_door")[1]
	beamDoor:SetKeyValue("wait", "5")
	beamDoor:SetKeyValue("spawnflags", "1280")
	local elevator = ents.FindByName("elevator")[1]
	elevator:Fire("AddOutput","OnNext elevator,StartForward,,45,-1",0)
	elevator:Fire("AddOutput","OnStart elevator,StartBackward,,45,-1",0)
end