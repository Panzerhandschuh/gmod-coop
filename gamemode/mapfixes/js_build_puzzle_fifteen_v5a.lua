HOOKS["InitPostEntity"] = function()
	ents.FindByName("painful_gun")[1]:Remove()
	ents.FindByName("trigger_gun")[1]:Remove()
	
	for k,v in pairs(ents.FindByClass("trigger_hurt")) do
		if(v:GetPos() == Vector(-4306.07, 4284.99, 198.5)) then
			v:Remove()
		end
	end
	
	for k,v in pairs(ents.FindByName("tube_glass*")) do
		if (v:GetName() != "tube_glass1") then
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
	counter:SetKeyValue("max", "9")
	counter:Fire("AddOutput","OnHitMax tube_glass1,Break,,0,-1",0)
	counter.requiredPuzzles = 7
	counter:Spawn()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.StartWith(k, "On") && string.match(v, "tube_glass*")) then
		e:Fire("AddOutput", k.." levelCounter,Add,1,0,1", 0)
	end

	if (k == "OnStartTouch" && v == "tube_glass1,Break,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end