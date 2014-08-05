HOOKS["InitPostEntity"] = function()
	ents.FindByName("painful_gun")[1]:Remove()
	ents.FindByName("trigger_gun")[1]:Remove()
	
	for k,v in pairs(ents.FindByClass("trigger_hurt")) do
		if(v:GetPos() == Vector(-4306.07, 4284.99, 198.5)) then
			v:Remove()
		end
	end
end