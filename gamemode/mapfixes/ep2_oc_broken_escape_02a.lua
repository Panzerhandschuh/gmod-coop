HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "weaponbox_template" && k == "spawnflags") then
		return "3"
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("weaponbox_template")[1]:Remove()
end