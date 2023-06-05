HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "drainage3") then
		e:Remove()
	elseif (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
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
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(-1392, -9856, 32)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,5,-1",0)
		end
	end
end