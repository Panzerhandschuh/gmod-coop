HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-4323, -2993, 156))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(-4174, -3824, 203.05)) then
			v:Fire("AddOutput","OnTrigger fcp1,SetAsCP,,0,-1",0)
		end
	end
	
	for k,v in pairs(ents.FindByClass("func_areaportal")) do
		v:Remove()
	end
	
	ents.FindByName("areaportal_trigger1")[1]:Remove()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnBallReinserted") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end
