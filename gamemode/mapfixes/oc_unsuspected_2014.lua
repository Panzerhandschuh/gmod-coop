HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("*upgrade*")) do
		if (v:GetClass() == "func_button") then
			v:Remove()
		end
	end
	
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if (v:GetPos() == Vector(7857, -3346.27, 338.5) || v:GetPos() == Vector(6372, -3350.27, 338.5)) then
			v:SetHealth(150)
		end
	end
end