HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(9096.5, -1821, -711)) then
			v:Fire("AddOutput","OnStartTouch relay_3,Trigger,,10,1",0)
		end
	end
end