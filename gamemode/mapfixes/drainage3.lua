HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "start_items_template" && k == "spawnflags") then
		return "3"
	elseif (e:GetClass() == "trigger_changelevel" && k == "map" && v == "drainage2") then
		e:Remove()
	end

	if(e:GetClass() == "prop_vehicle_airboat") then
		if(k == "vehiclescript") then
			e.script = v
		end
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("start_items_template")[1]:Remove()

	for k,v in pairs(ents.FindByClass("prop_vehicle_airboat")) do
		v:SetSolid(SOLID_NONE)
		
		local s = ents.Create("vehicle_spawner")
		s:SetPos(v:GetPos())
		s:SetAngles(v:GetAngles())
		s.jmodel = v:GetModel()
		s.jscript = v.script
		s.jeep = false
		s:Spawn()
		
		v:Remove()
	end
end