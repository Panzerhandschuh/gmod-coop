HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:GetClass() == "prop_vehicle_airboat") then
		if(k == "vehiclescript") then
			e.script = v
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local button = ents.FindByName("button1")[1]
	button:Fire("AddOutput","OnPressed elevator,StartForward,,1,-1",0)
	button:SetKeyValue("wait", "10")

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