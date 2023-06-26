HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 3)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end

	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "metastasis_3") then
		e:Remove()
	end
end

HOOKS["InitPostEntity"] = function()
	local cp1 = ents.Create("coop_checkpoint")
	cp1:SetName("cp1")
	cp1:SetPos(Vector(-1040, -1968, -6016))
	cp1:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(-1040, -1976, -10400)) then
			v:Fire("AddOutput","OnTrigger cp1,SetAsCP,,0,-1",0)
			v:Fire("AddOutput","OnTrigger player,AddOutput,origin -1040 -1968 -10448,0,-1",0)
		end
	end

	local cp2 = ents.Create("coop_checkpoint")
	cp2:SetName("cp2")
	cp2:SetPos(Vector(-455, -291, -563))
	cp2:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(-648, -320, -1584)) then
			v:Fire("AddOutput","OnTrigger cp2,SetAsCP,,0,-1",0)
			v:Fire("AddOutput","OnTrigger player,AddOutput,origin -656 -288 -1560,0,-1",0)
		end
	end

	for k,v in pairs(ents.FindByClass("env_fade")) do
		v:Remove()
	end
end