HOOKS["InitPostEntity"] = function()
	ents.FindByName("b2")[1]:SetKeyValue("wait", "30")
	ents.FindByName("b3zombie")[1]:SetKeyValue("wait", "30")
	ents.FindByName("button_pits_a")[1]:SetKeyValue("wait", "30")
	ents.FindByName("b3ittybuttontopit_2")[1]:SetKeyValue("wait", "30")
	ents.FindByName("b3ittybuttontopit_3")[1]:SetKeyValue("wait", "30")
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