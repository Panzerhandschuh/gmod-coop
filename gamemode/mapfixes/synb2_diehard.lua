HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 258 && k == "spawnflags") then
		return "1024"
	end
	if(e:EntIndex() == 260 && k == "spawnflags") then
		return "1024"
	end
end