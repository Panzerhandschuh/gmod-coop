HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 273 && k == "spawnflags") then
		return "1024"
	end
	if(e:EntIndex() == 275 && k == "spawnflags") then
		return "1024"
	end
	if(e:GetName() == "man1" && k == "spawnflags") then
		return "3840"
	end
end

-- Fix npc not being registered as killed by a npc_maker
HOOKS["EntityTakeDamage"] = function(target, dmg)
	if (target:GetClass() == "npc_manhack") then
		if (dmg:GetInflictor() == target) then
			dmg:SetDamage(0)
		end
	end

	return dmg
end