HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("headcrabSpawne*")) do
		v:SetKeyValue("MaxNPCCount", "20")
	end
	
	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(-5992.14, 4060, 3132)) then
			v:Fire("Addoutput", "OnStartTouch headcrabSpawner,Enable,,0,-1", 0)
			v:Fire("Addoutput", "OnStartTouch headcrabSpawner2,Enable,,0,-1", 0)
		end
	end
	
	ents.FindByName("headcrabSpawner")[1]:SetPos(Vector(-5980, 4628, 3232))
	ents.FindByName("headcrabSpawner2")[1]:SetPos(Vector(-5980, 4596, 3232))
end