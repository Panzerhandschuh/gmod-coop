HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByName("Level*door")) do
		if (v:GetName() != "Level1door") then
			v:Remove()
		end
	end

	local counter = ents.Create("math_counter")
	counter:SetPos(Vector(0, 0, 0))
	counter:SetAngles(Angle(0, 0, 0))
	counter:SetName("levelCounter")
	counter:SetKeyValue("StartDisabled", "0")
	counter:SetKeyValue("startvalue", "0")
	counter:SetKeyValue("min", "0")
	counter:SetKeyValue("max", "5")
	counter:Fire("AddOutput","OnHitMax Level1door,Kill,,0,-1",0)
	counter.requiredPuzzles = 5
	counter:Spawn()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.StartWith(k, "On") && string.match(v, "Level%ddoor")) then
		e:Fire("AddOutput", k.." levelCounter,Add,1,0,1", 0)
	end

	if (k == "OnHitMax" && v == "Level1door,Kill,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end