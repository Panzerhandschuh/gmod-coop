HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		elseif (k == "SpawnFrequency") then
			return math.Round(v * 0.6)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(-2302, -416, -322)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,30,-1",0)
		end
	end

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(-2302, -416, -322)) then
			v:Remove()
		end
	end
end