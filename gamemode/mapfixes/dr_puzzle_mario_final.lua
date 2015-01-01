HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("trigger_push")) do
		if (v:GetPos() == Vector(-9912, -10992, 5604) || v:GetPos() == Vector(-10336, -10744, 5764)) then
			v:SetKeyValue("speed", "10")
		end
	end
	
	local box = ents.FindByName("puzzle4_box")[1]
	box:SetHealth(120)
end
