HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_changelevel" && k == "landmark" && v == "levelchanger1") then
		e:Remove()
	end
end