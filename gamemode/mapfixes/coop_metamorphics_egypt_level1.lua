HOOKS["InitPostEntity"] = function()
	ents.FindByName("b2")[1]:Remove()
	ents.FindByName("b3zombie")[1]:Remove()
	ents.FindByName("b3ittybuttontopit_2")[1]:Remove()
	ents.FindByName("b3ittybuttontopit_3")[1]:Remove()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.match(e:GetName(), "crowbar")) then
		e:Remove()
		return ""
	elseif (string.match(e:GetName(), "cannon")) then
		e:Remove()
		return ""
	elseif (string.match(e:GetName(), "pistol")) then
		e:Remove()
		return ""
	end
end