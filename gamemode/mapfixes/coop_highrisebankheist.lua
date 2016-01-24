HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("npc_citizen")) do
		v:SetKeyValue("GameEndAlly", "0")
	end
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(53, 43, 56.5)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,10,-1",0)
		end
	end
end

HOOKS["OnEntityCreated"] = function(ent)
	if (ent:GetClass() == "npc_citizen") then
		ent:AddRelationship("player D_HT 99")
	end
end