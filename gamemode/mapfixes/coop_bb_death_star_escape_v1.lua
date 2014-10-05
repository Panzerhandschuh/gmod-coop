HOOKS["InitPostEntity"] = function()
	ents.FindByName("demo_ad")[1]:Remove()
	ents.FindByName("demo_text3")[1]:Remove()
	ents.FindByName("demo_end")[1]:Remove()
	
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-2300, 1792, 62))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	local e = ents.FindByName("WeaponroomDoor")[1]
	e:Fire("AddOutput","OnOpen fcp1,SetAsCP,,0,1",0)
	
	for k,v in pairs(ents.FindByClass("trigger_hurt")) do
		if (v:GetPos() == Vector(4224, -6176, -192)) then
			v:SetKeyValue("spawnflags", "3")
		end
	end
end

-- Adjust spawners to be less boring
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 0.8)
		elseif (k == "SpawnFrequency") then
			return v * 0.8
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 1.5)
		end
	end
end