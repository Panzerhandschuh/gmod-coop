HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(512, 240, 552))
	cp:SetAngles(Angle(0,270,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-2871, -857, -1107))
	cp:SetAngles(Angle(0,90,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(944.5, 296.5, 466.5)) then
			v:Fire("AddOutput","OnTrigger fcp1,SetAsCP,,0,-1",0)
		elseif(v:GetPos() == Vector(-2881, -469.5, -1097)) then
			v:Fire("AddOutput","OnTrigger fcp2,SetAsCP,,0,-1",0)
		end
	end
end