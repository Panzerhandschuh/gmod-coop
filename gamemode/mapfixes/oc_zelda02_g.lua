HOOKS["EntityKeyValue"] = function(e,k,v)
	if(k == "OnStartTouch" && v == "!activator,SetTeam,2,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1" --so that it registers a change
	elseif(k == "OnStartTouch" && v == "start_teleport,Disable,,300,1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	elseif(k == "OnTrigger" && v == "start_teleport,Disable,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	elseif(k == "OnTrigger" && v == "start_teleport,Disable,,30,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("rescue_door*")) do
		v:Remove()
	end
	
	ents.FindByName("shutter04_close")[1]:Remove()
	ents.FindByName("shutter4c_close")[1]:Remove()
	
	for k,v in pairs(ents.FindByName("door07")) do
		v:Remove()
	end
	ents.FindByName("door07_hole")[1]:Remove()
	ents.FindByName("door07_trigger")[1]:Remove()
	
	for k,v in pairs(ents.FindByName("door02")) do
		v:Remove()
	end
	ents.FindByName("door02_hole")[1]:Remove()
	ents.FindByName("door02_trigger")[1]:Remove()
	
	for k,v in pairs(ents.FindByName("door06")) do
		v:Remove()
	end
	ents.FindByName("door06_hole")[1]:Remove()
	ents.FindByName("door06_trigger")[1]:Remove()
	
	ents.FindByName("bossdoor_saku")[1]:Fire("Open")
end

HOOKS["OnEntityCreated"] = function(ent)
	if(string.sub(ent:GetClass(),1,4) == "npc_") then
		timer.Simple(0.1,function()
			if(ent.health) then
				ent:SetHealth(ent.health)
			end
			if(ent:IsValid() && string.sub(ent:GetClass(),1,12) == "npc_headcrab") then
				ent:SetHealth(1)
			end
		end)
	end
end