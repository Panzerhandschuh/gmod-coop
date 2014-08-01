HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("func_button")) do
		if (v:GetPos() == Vector(956.55, -247, -9)) then
			v:SetKeyValue("wait", "10")
		end
	end
	
	for k,v in pairs(ents.FindByName("lift")) do
		v:SetKeyValue("speed", "400")
	end
end