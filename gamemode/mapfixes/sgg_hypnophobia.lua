HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnPressed" && v == "beginning_door,Lock,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end

	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 4)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local beamDoor = ents.FindByName("razor_beam_door")[1]
	beamDoor:SetKeyValue("wait", "5")
	beamDoor:SetKeyValue("spawnflags", "1280")
	
	local elevator = ents.FindByName("elevator")[1]
	elevator:SetKeyValue("startspeed", "250")
	elevator:Fire("AddOutput","OnStart elevator,StartForward,,40,-1",0)
	elevator:Fire("AddOutput","OnStart elevator,TeleportToPathTrack,elevator_track_1,20,-1",0)
end