HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if(v:GetPos() == Vector(-11036, -2131, 1306.67)) then
			local pos = v:GetPos()
			pos.z = pos.z - 4
			v:SetPos(pos)
		end
	end
	
	for k,v in pairs(ents.FindByClass("trigger_teleport")) do
		if(v:GetPos() == Vector(-11853, 6754, -33)) then
			v:Fire("AddOutput","OnStartTouch level7_completed_light,ShowSprite,,0,-1",0)
		end
	end
	
	local counter = ents.Create("math_counter")
	counter:SetPos(Vector(0, 0, 0))
	counter:SetAngles(Angle(0, 0, 0))
	counter:SetName("levelCounter")
	counter:SetKeyValue("StartDisabled", "0")
	counter:SetKeyValue("startvalue", "0")
	counter:SetKeyValue("min", "0")
	counter:SetKeyValue("max", "8")
	counter:Fire("AddOutput","OnHitMax fakegameender,EndGame,,10,-1",0)
	counter:Spawn()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.StartWith(k, "On") && string.match(v, "level%d_completed_light")) then
		e:Fire("AddOutput", k.." levelCounter,Add,1,0,1", 0)
	end
end