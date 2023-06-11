-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_ar2")
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 4)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_teleport")) do
		if (v:GetPos() == Vector(9977, -1226, -2564)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,5,-1",0)
		end
	end
end