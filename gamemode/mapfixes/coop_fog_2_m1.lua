HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 2)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		elseif (k == "SpawnFrequency") then
			return math.Round(v * 0.5)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local dest = ents.Create("info_teleport_destination")
	dest:SetKeyValue("targetname", "fix1")
	dest:SetKeyValue("origin", "-2028 -2880 382")
	dest:SetKeyValue("angles", "0 180 0")
	dest:Spawn()

	local tele = ents.Create("trigger_teleport")
	tele:SetKeyValue("model", "*61")
	tele:SetKeyValue("spawnflags", "1")
	tele:SetKeyValue("origin", "-2028 -2956 -144")
	tele:SetKeyValue("target", "fix1")
	tele:Spawn()
end

-- HOOKS["EntityTakeDamage"] = function(e,dmg)
-- 	if (e:GetClass() == "npc_citizen") then
-- 		dmg:SetDamage(0)
-- 	end
	
-- 	return dmg
-- end