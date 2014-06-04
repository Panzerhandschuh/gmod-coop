HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 448 && k == "spawnflags") then
		return "770"
	end
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("jokulaskuri")) do
		v:Fire("AddOutput","OnHitMax fakegameender,EndGame,,25,-1",0)
	end
end
