HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "template_weapons" && k == "spawnflags") then
		return "3"
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("template_weapons")[1]:Remove()
end