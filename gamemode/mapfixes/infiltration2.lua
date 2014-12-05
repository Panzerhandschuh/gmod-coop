HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "Infiltration1") then
		e:Remove()
	end
end