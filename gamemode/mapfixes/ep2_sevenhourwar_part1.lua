HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(2144, 2912, 664))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(2283, 2901, 676)) then
			v:Fire("AddOutput","OnStartTouch fcp1,SetAsCP,,0,-1",0)
		end
	end
end