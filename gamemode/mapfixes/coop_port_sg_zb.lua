HOOKS["InitPostEntity"] = function()
	ents.FindByName("template_rpg")[1]:Remove()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "template_rpg" && k == "spawnflags") then
		return "3"
	end
end