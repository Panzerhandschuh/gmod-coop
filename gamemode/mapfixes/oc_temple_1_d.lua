HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(2712, 7616, -4757.5)) then
			v:SetKeyValue("spawnflags", "2")
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_once" && e:GetPos() == Vector(2712, 7616, -4757.5) && k == "OnTrigger") then
		if (string.find(v, "175")) then
			return string.gsub(v, "175", "85")
		elseif (string.find(v, "180")) then
			return string.gsub(v, "180", "90")
		end
	end
end

HOOKS["EntityTakeDamage"] = function(e,dmg)
	if (e:GetClass() == "npc_citizen") then
		dmg:SetDamage(0)
	end
	
	return dmg
end