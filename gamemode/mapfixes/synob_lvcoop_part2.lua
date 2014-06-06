HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:GetName() == "big_citadel_door1" && k == "spawnflags") then
		return "2816"
	end
end
