HOOKS["InitPostEntity"] = function()
	ents.FindByName("temp_roue")[1]:Remove()
	ents.FindByName("temp_turret_15_coffre_munition_1")[1]:Remove()

	for k,v in pairs(ents.FindByName("turret_1*_coffre_munition_1")) do
		print(v:GetName())
		v:GetPhysicsObject():SetMass(200)
	end
	
	for k,v in pairs(ents.FindByName("roue*")) do
		if (v:GetClass() == "func_physbox") then
			v:GetPhysicsObject():SetMass(200)
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "temp_roue" || e:GetName() == "temp_turret_15_coffre_munition_1" && k == "spawnflags") then
		return "3"
	elseif (e:GetName() == "plug_counter" && k == "max") -- Fix plugs breaking sometimes by only requiring one
		return "1"
	end
end