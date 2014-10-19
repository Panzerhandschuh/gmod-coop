HOOKS["InitPostEntity"] = function()
	local wheel = ents.FindByName("valvetoopengate")[1]
	wheel:SetKeyValue("distance", "800")
	wheel = ents.FindByName("valve")[1]
	wheel:SetKeyValue("distance", "800")
	
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if (v:GetPos() == Vector(-7089, 4209, -687)) then
			v:SetHealth(2500)
		end
	end
end