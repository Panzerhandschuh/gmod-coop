HOOKS["PlayerCanPickupWeapon"] = function(ply, wep)
	-- Fixes weapon pickup output not firing for replacement weapons
	if (wep.hasPickupOutput) then
		wep:Input("FireUser1")
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	-- Add pickup output
	if (string.StartsWith(e:GetClass(), "weapon_") && k == "OnPlayerPickup") then
		e:SetKeyValue("OnUser1", v)
		e.hasPickupOutput = true
		return ""
	end

	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 0.75)
		end
	end
end