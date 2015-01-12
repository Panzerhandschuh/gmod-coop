HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if (v:GetPos() == Vector(-7089, 4209, -687) || v:GetPos() == Vector(-7082, 4200, -687)) then
			v:SetHealth(2400)
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "momentary_rot_button" && k == "distance") then
		return "900"
	end
end