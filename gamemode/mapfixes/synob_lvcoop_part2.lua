HOOKS["InitPostEntity"] = function()
	ents.FindByName("big_citadel_door1")[1]:Remove()
	ents.FindByName("clip_combineshieldwall3")[1]:Remove()
	ents.FindByName("clip_combineshieldwall4")[1]:Remove()
	ents.FindByName("brush_combineshieldwall3")[1]:Remove()
	ents.FindByName("brush_combineshieldwall4")[1]:Remove()
	
	-- Lower counters for now until fixing npc path targets
	local counter1 = ents.FindByName("end_counter1")[1]
	counter1:SetKeyValue("max", "5")
	local counter2 = ents.FindByName("end_counter2")[1]
	counter2:SetKeyValue("max", "30")
	
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-4800, -4000, -120))
	cp:SetAngles(Angle(0,270,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-7056, -9472, 552))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	local ent = ents.FindByName("trigger_combineshieldwall1")[1]
	ent:Fire("AddOutput","OnStartTouch fcp1,SetAsCP,,0,1",0)
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(-7288, -9480, 576)) then
			v:Fire("AddOutput","OnStartTouch fcp2,SetAsCP,,0,-1",0)
		end
	end
end