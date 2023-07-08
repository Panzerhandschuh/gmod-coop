HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 3)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end

	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "metastasis_2") then
		e:Remove()
	end
end

HOOKS["InitPostEntity"] = function()
	local cp1 = ents.Create("coop_checkpoint")
	cp1:SetName("cp1")
	cp1:SetPos(Vector(4672, 0, 7480))
	cp1:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(4684, 0, 7536)) then
			v:Fire("AddOutput","OnTrigger cp1,SetAsCP,,0,-1",0)
			v:Fire("AddOutput","OnTrigger player,AddOutput,origin 4672 0 7480,0,-1",0)
		end
	end

	local cp2 = ents.Create("coop_checkpoint")
	cp2:SetName("cp2")
	cp2:SetPos(Vector(6144, -928, 1288))
	cp2:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(6144, -1048, 7444)) then
			v:Fire("AddOutput","OnTrigger cp2,SetAsCP,,0,-1",0)
			v:Fire("AddOutput","OnTrigger player,AddOutput,origin 6144 -1040 7348,0,-1",0)
		end
	end

	local cp3 = ents.Create("coop_checkpoint")
	cp3:SetName("cp3")
	cp3:SetPos(Vector(6144, -896, 1288))
	cp3:Spawn()

	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(6144, -1048, 1344)) then
			v:Fire("AddOutput","OnTrigger cp3,SetAsCP,,0,-1",0)
			v:Fire("AddOutput","OnTrigger player,AddOutput,origin 6144 -1040 7360,0,-1",0)
		end
	end

	for k,v in pairs(ents.FindByName("shaft-base-doors-1-1")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByName("shaft-base-doors-1-2")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByName("shaft-base-doors-1-3")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByName("teleport-corridor-door-1")) do
		v:Remove()
	end

	for k,v in pairs(ents.FindByClass("env_fade")) do
		v:Remove()
	end
end