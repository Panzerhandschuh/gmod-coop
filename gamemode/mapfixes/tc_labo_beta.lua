-- Fix npc not being registered as killed by a npc_maker
HOOKS["EntityTakeDamage"] = function(target, dmg)
	if (target:GetClass() == "npc_manhack") then
		if (dmg:GetInflictor() == target) then
			dmg:SetDamage(0)
		end
	end

	return dmg
end