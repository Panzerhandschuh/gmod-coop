-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_357")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")
	end )
end

HOOKS["InitPostEntity"] = function()
	timer.Simple(1, function() -- Use timer to get replaced entities
		for k,v in pairs(ents.FindByClass("item*")) do
			local pos = v:GetPos()
			if (pos.x > 416 && pos.y > -1192 && pos.x < 928 && pos.y < -736) then
				v:Remove()
			end
		end
		
		for k,v in pairs(ents.FindByClass("weapon*")) do
			local pos = v:GetPos()
			if (pos.x > 416 && pos.y > -1192 && pos.x < 928 && pos.y < -736) then
				v:Remove()
			end
		end
	end)
	
	ents.FindByName("trig_m1_08")[1]:Fire("AddOutput", "OnStartTouch door_end_p1,Open,,40,-1",0)
	
	local wep1 = ents.Create("weapon_shotgun")
	wep1:SetPos(Vector(512, -288, -943))
	wep1:SetAngles(Angle(0, 0, 0))
	wep1.ei = 0.1
	wep1.oPos = Vector(512, -288, -943)
	wep1.oAng = Angle(0, 0, 0)
	wep1:Spawn()
	
	local wep2 = ents.Create("weapon_shotgun")
	wep2:SetPos(Vector(512, -300, -943))
	wep2:SetAngles(Angle(0, 0, 0))
	wep2.ei = 0.2
	wep2.oPos = Vector(512, -300, -943)
	wep2.oAng = Angle(0, 0, 0)
	wep2:Spawn()
	
	local wep3 = ents.Create("weapon_shotgun")
	wep3:SetPos(Vector(512, -312, -943))
	wep3:SetAngles(Angle(0, 0, 0))
	wep3.ei = 0.3
	wep3.oPos = Vector(512, -312, -943)
	wep3.oAng = Angle(0, 0, 0)
	wep3:Spawn()
end