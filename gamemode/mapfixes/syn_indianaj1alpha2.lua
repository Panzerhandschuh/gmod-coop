HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-2560, 4640, -120))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-2224, 5516, 184))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	local e = ents.FindByName("door2")[1]
	e:Fire("AddOutput","OnOpen fcp1,SetAsCP,,0,1",0)
	
	e = ents.FindByName("door4")[1]
	e:Fire("AddOutput","OnOpen fcp2,SetAsCP,,0,1",0)
end