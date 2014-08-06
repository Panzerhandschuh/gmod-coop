HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "syn_canal_escape_part1") then
		e:Remove()
	end
end