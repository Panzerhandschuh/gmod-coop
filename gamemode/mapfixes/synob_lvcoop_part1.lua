HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 433 && k == "spawnflags") then
		return "770"
	end
end