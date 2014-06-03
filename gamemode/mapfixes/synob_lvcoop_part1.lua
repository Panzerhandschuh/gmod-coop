HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 448 && k == "spawnflags") then
		return "770"
	end
end