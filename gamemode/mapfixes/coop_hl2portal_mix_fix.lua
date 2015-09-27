HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if (v:GetPos() == Vector(-137.5, 3296, -28) || v:GetPos() == Vector(-504.5, 3296, -28)) then
			v:SetName("breakable_glass")
		elseif (v:GetPos() == Vector(-898, 3200, 56) || v:GetPos() == Vector(-1880, 3228, -54)) then
			v:SetKeyValue("health", "400")
		end
	end
	
	ents.FindByName("point_rpg")[1]:Remove()

	local counter = ents.FindByName("counter_timer_stop")[1]
	counter:SetKeyValue("max", "3")
	
	ents.FindByName("button_enable_turret")[1]:Fire("AddOutput","OnPressed breakable_glass,break,,2,1",0)
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "point_rpg" && k == "spawnflags") then
		return "3"
	end
end