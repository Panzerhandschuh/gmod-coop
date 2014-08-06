HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("g12")[1]
	ent:Fire("AddOutput","OnPass mech3,Lock,,0,-1",0)
	
	for k,v in pairs(ents.FindByClass("func_button")) do
		if (v:GetPos() == Vector(7183.5, 660, 110) || v:GetPos() == Vector(937.5, 11876, -498)) then
			v:SetKeyValue("wait", "8")
		end
	end
end