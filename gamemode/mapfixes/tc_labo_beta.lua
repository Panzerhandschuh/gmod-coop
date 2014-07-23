-- Fix npc not being registered as killed by a npc_maker
HOOKS["EntityTakeDamage"] = function(target, dmg)
	if (target:GetClass() == "npc_manhack") then
		if (dmg:GetInflictor() == target) then
			dmg:SetDamage(0)
		end
	end

	return dmg
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("combinemaker09")) do
		v:Fire("AddOutput","OnAllSpawnedDead fakegameender,EndGame,,25,-1",0)
	end
end