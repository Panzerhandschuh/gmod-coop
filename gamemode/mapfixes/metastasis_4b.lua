HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 3)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end

	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "metastasis_4a") then
		e:Remove()
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("info_player_start")) do
		v:SetPos(Vector(0, -312, -652))
	end

	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_teleport")) do
		if (v:GetPos() == Vector(928, -3104, 64)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,40,-1",0)
		end
	end
end