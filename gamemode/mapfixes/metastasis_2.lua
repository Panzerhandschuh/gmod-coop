HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 3)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end

	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "metastasis_1") then
		e:Remove()
	end
end

HOOKS["InitPostEntity"] = function()
	local cp1 = ents.Create("coop_checkpoint")
	cp1:SetName("cp1")
	cp1:SetPos(Vector(-776, -288, -3640))
	cp1:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(-656, -320, -576)) then
			v:Fire("AddOutput","OnTrigger cp1,SetAsCP,,0,-1",0)
			v:Fire("AddOutput","OnTrigger player,AddOutput,origin -656 -288 -560,0,-1",0)
		end
	end

	for k,v in pairs(ents.FindByClass("info_player_start")) do
		if (v:GetPos() == Vector(-368.002991, 720.776978, -324.000000)) then
			v:Remove()
		end
	end

	for k,v in pairs(ents.FindByClass("env_fade")) do
		v:Remove()
	end
end