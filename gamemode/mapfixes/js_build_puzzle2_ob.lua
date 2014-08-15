HOOKS["InitPostEntity"] = function()
	local counter = ents.Create("math_counter")
	counter:SetPos(Vector(0, 0, 0))
	counter:SetAngles(Angle(0, 0, 0))
	counter:SetName("levelCounter")
	counter:SetKeyValue("StartDisabled", "0")
	counter:SetKeyValue("startvalue", "0")
	counter:SetKeyValue("min", "0")
	counter:SetKeyValue("max", "6")
	counter:Fire("AddOutput","OnHitMax gate_door,Kill,,0,-1",0)
	counter.requiredPuzzles = 6
	counter:Spawn()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.StartWith(k, "On") && string.match(v, "level_%d+,Display")) then
		e:Fire("AddOutput", k.." levelCounter,Add,1,0,1", 0)
	end
end