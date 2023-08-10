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
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()

	ents.FindByName("final_trigger")[1]:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,30,-1",0)

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(-104, 224, 58)) then
			v:SetPos(Vector(-104, 224, -454))
		end
	end
end