HOOKS["OnEntityCreated"] = function(ent)
	if(ent:GetClass() == "prop_vehicle_airboat") then
		timer.Simple(0.1,function()
			if(ent:IsValid()) then
				if(ent:GetKeyValues().vehiclescript != "scripts/vehicles/airboat_ob.txt") then
					ent:SetKeyValue("vehiclescript","scripts/vehicles/airboat_ob.txt")
					ent:Spawn()
				end
			end
		end)
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(k == "model" && v == "models/props_wasteland/hollow_container.mdl") then
		return "models/props_wasteland/cargo_container01b.mdl"
	end
	if(string.sub(e:GetName(),1,6) == "box_10" && k == "skin") then
		return "0"
	end
end