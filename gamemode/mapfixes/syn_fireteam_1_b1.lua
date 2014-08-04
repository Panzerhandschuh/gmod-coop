HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:GetClass() == "prop_vehicle_jeep") then
		if(k == "vehiclescript") then
			e.script = v
		end
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		v:SetSolid(SOLID_NONE)
		
		local s = ents.Create("vehicle_spawner")
		s:SetPos(v:GetPos())
		s:SetAngles(v:GetAngles())
		s.jmodel = v:GetModel()
		s.jscript = v.script
		s:Spawn()
		
		v:Remove()
	end
end