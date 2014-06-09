HOOKS["EntityKeyValue"] = function(e,k,v)
	if(k == "OnStartTouch" && v == "!activator,SetTeam,2,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1" --so that it registers a change
	end
	if(k == "npchealth") then
		e.health = tonumber(v)
	end
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