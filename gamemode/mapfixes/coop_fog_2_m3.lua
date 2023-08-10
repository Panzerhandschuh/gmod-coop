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

	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "fog_2_m2") then
		e:Remove()
	end
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(48, 629, -616)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,20,-1",0)
		end
	end
end

-- HOOKS["EntityTakeDamage"] = function(e,dmg)
-- 	if (e:GetClass() == "npc_citizen") then
-- 		dmg:SetDamage(0)
-- 	end
	
-- 	return dmg
-- end