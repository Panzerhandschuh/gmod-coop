HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("*upgrade*")) do
		if (v:GetClass() == "func_button") then
			v:Remove()
		end
	end
end