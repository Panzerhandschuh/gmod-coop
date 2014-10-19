HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("trigger_push")) do
		if (v:GetPos() == Vector(-9912, -10992, 5604) || v:GetPos() == Vector(-10336, -10744, 5764)) then
			v:SetKeyValue("speed", "120")
		end
	end
end
