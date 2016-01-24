HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	ents.FindByName("twins_kills_counter")[1]:Fire("AddOutput","OnHitMax fakegameender,EndGame,,10,-1",0)
end

HOOKS["OnEntityCreated"] = function(ent)
	if (ent:GetClass() == "npc_citizen") then
		ent:AddRelationship("player D_HT 99")
	end
end