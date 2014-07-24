HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-12816, -5648, -184))
	cp:SetAngles(Angle(0,270,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
		
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-6712, -9440, -208))
	cp:SetAngles(Angle(0,270,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(-13084, -5492, -160)) then
			v:Fire("AddOutput","OnStartTouch fcp1,SetAsCP,,0,-1",0)
		end
	end
	
	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(-6351, -9484, -176)) then
			v:Fire("AddOutput","OnStartTouch fcp2,SetAsCP,,0,1",0)
		end
	end
end