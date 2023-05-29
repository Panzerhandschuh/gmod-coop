-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_357")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")
		ply:Give("weapon_crossbow")
		ply:Give("weapon_rpg")

		ply:GiveAmmo(6, "357", true)
		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(30, "ar2", true)
		ply:GiveAmmo(30, "buckshot", true)
		ply:GiveAmmo(5, "xbowbolt", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:GetClass() == "prop_vehicle_jeep") then
		if(k == "vehiclescript") then
			e.script = v
		end
	end
	if(k == "OnTrigger" && v == "Cutscene_Camera_7_1,Disable,,35,-1") then
		return "Cutscene_Camera_7_1,AddOutput,targetname dummy,35,-1"
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		v:SetSolid(SOLID_NONE)
		
		local s = ents.Create("vehicle_spawner")
		s:SetName(v:GetName())
		s:SetPos(v:GetPos())
		s:SetAngles(v:GetAngles())
		s.jmodel = v:GetModel()
		s.jscript = v.script
		s.jeep = true
		s:Spawn()
		
		v:Remove()
	end
	
	local r1 = ents.Create("weapon_rpg")
	r1:SetPos(Vector(-9320, 4526, 1891))
	r1:SetAngles(Angle(0, 0, 0))
	r1.ei = 0.1
	r1.oPos = Vector(-9320, 4526, 1891)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()

	local r2 = ents.Create("weapon_rpg")
	r2:SetPos(Vector(-9280, 4526, 1891))
	r2:SetAngles(Angle(0, 0, 0))
	r2.ei = 0.2
	r2.oPos = Vector(-9280, 4526, 1891)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
	
	local r3 = ents.Create("weapon_rpg")
	r3:SetPos(Vector(-9240, 4526, 1891))
	r3:SetAngles(Angle(0, 0, 0))
	r3.ei = 0.3
	r3.oPos = Vector(-9240, 4526, 1891)
	r3.oAng = Angle(0, 0, 0)
	r3:Spawn()

end