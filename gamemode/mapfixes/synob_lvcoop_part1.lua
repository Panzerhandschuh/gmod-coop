HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 448 && k == "spawnflags") then
		return "770"
	end
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("jokulaskuri")) do
		v:Fire("AddOutput","OnHitMax fakegameender,EndGame,,25,-1",0)
	end
	
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-2240, -1096, -540))
	cp:SetAngles(Angle(0,90,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-8688, -1344 -456))
	cp:SetAngles(Angle(0,270,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(-2240, -1096, -540)) then
			v:Fire("AddOutput","OnStartTouch fcp1,SetAsCP,,0,-1",0)
		elseif(v:GetPos() == Vector(-8688, -1464, -424.01)) then
			v:Fire("AddOutput","OnStartTouch fcp2,SetAsCP,,0,-1",0)
		end
	end
end
