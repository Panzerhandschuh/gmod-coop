HOOKS["InitPostEntity"] = function()
	ents.FindByName("room01")[1]:Remove()
	ents.FindByName("bouton01")[1]:Remove()
	
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if(v:GetPos() == Vector(7264, -818, 7.5)) then
			v:Remove()
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(string.find(e:GetName(), "trigger0*") && e:GetName() != "trigger06" && e:GetName() != "trigger10") then
		if (k == "OnStartTouch" && string.find(v, "door")) then
			return "!activator,AddOutput,dummykey 0,0,-1"
		end
	end
end