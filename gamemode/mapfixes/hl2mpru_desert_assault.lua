HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:GetName() == "garage_maker_1" && k == "spawnflags") then
		return "16"
	end
	if(e:GetName() == "garage_maker_2" && k == "spawnflags") then
		return "16"
	end
	if(e:GetName() == "garage_maker_3" && k == "spawnflags") then
		return "16"
	end
end