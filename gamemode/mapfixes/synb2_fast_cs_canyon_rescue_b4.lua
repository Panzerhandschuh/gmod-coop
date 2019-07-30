HOOKS["EntityTakeDamage"] = function(e,dmg)
	if (e:GetClass() == "npc_citizen") then
		dmg:SetDamage(0)
	end
	
	return dmg
end