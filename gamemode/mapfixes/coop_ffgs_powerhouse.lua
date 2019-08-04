HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple(0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")
	end)
end

HOOKS["InitPostEntity"] = function()
	local smg1 = ents.Create("item_ammo_smg1")
	smg1:SetPos(Vector(292, -2390, 39))
	smg1.oPos = Vector(292, -2390, 39)
	smg1.oAng = Angle(0, 0, 0)
	smg1.ei = 0.1
	smg1:Spawn()

	local smg2 = ents.Create("item_ammo_smg1")
	smg2:SetPos(Vector(-300, 564, 40))
	smg2.oPos = Vector(-300, 564, 40)
	smg2.oAng = Angle(0, 0, 0)
	smg2.ei = 0.2
	smg2:Spawn()

	local smg3 = ents.Create("item_ammo_smg1")
	smg3:SetPos(Vector(0, 560, 199))
	smg3.oPos = Vector(0, 560, 199)
	smg3.oAng = Angle(0, 0, 0)
	smg3.ei = 0.3
	smg3:Spawn()

	local shotgun1 = ents.Create("item_box_buckshot")
	shotgun1:SetPos(Vector(-1240, -928, 38))
	shotgun1.oPos = Vector(-1240, -928, 38)
	shotgun1.oAng = Angle(0, 0, 0)
	shotgun1.ei = 0.4
	shotgun1:Spawn()

	local shotgun2 = ents.Create("item_box_buckshot")
	shotgun2:SetPos(Vector(952, -1540, 72))
	shotgun2.oPos = Vector(952, -1540, 72)
	shotgun2.oAng = Angle(0, 0, 0)
	shotgun2.ei = 0.5
	shotgun2:Spawn()

	local shotgun3 = ents.Create("item_box_buckshot")
	shotgun3:SetPos(Vector(316, -1780, 198))
	shotgun3.oPos = Vector(316, -1780, 198)
	shotgun3.oAng = Angle(0, 0, 0)
	shotgun3.ei = 0.6
	shotgun3:Spawn()

	local ar21 = ents.Create("item_ammo_ar2")
	ar21:SetPos(Vector(60, -1368, 230))
	ar21.oPos = Vector(60, -1368, 230)
	ar21.oAng = Angle(0, 0, 0)
	ar21.ei = 0.61
	ar21:Spawn()

	local ar22 = ents.Create("item_ammo_ar2")
	ar22:SetPos(Vector(-441, -274, 226))
	ar22.oPos = Vector(-441, -274, 226)
	ar22.oAng = Angle(0, 0, 0)
	ar22.ei = 0.62
	ar22:Spawn()

	local ar23 = ents.Create("item_ammo_ar2")
	ar23:SetPos(Vector(760, 32, 66))
	ar23.oPos = Vector(760, 32, 66)
	ar23.oAng = Angle(0, 0, 0)
	ar23.ei = 0.63
	ar23:Spawn()

	local revolver = ents.Create("weapon_357")
	revolver:SetPos(Vector(946, -670, 226))
	revolver.oPos = Vector(946, -670, 226)
	revolver.oAng = Angle(0, 0, 0)
	revolver.ei = 0.7
	revolver:Spawn()

	local revolverA = ents.Create("item_ammo_357")
	revolverA:SetPos(Vector(-432, -2472, 36))
	revolverA.oPos = Vector(-432, -2472, 36)
	revolverA.oAng = Angle(0, 0, 0)
	revolverA.ei = 0.8
	revolverA:Spawn()

	local crossbow = ents.Create("weapon_crossbow")
	crossbow:SetPos(Vector(-1472, -1286, 226))
	crossbow.oPos = Vector(-1472, -1286, 226)
	crossbow.oAng = Angle(0, 0, 0)
	crossbow.ei = 0.9
	crossbow:Spawn()

	local crossbowA = ents.Create("item_ammo_crossbow")
	crossbowA:SetPos(Vector(-488, -2154, 193))
	crossbowA.oPos = Vector(-488, -2154, 193)
	crossbowA.oAng = Angle(0, 0, 0)
	crossbowA.ei = 0.91
	crossbowA:Spawn()

	local grenade1 = ents.Create("weapon_frag")
	grenade1:SetPos(Vector(174, -406, 198))
	grenade1.oPos = Vector(174, -406, 198)
	grenade1.oAng = Angle(0, 0, 0)
	grenade1.ei = 0.92
	grenade1:Spawn()

	ents.FindByName("template_helicopter_maker")[1]:SetKeyValue("SpawnFrequency", "20")
	ents.FindByName("template_helicopter_maker")[1]:SetKeyValue("MaxLiveChildren", "2")
	ents.FindByName("template_helicopter_maker")[1]:SetKeyValue("MaxNPCCount", "2")
	ents.FindByName("template_helicopter_maker_w4")[1]:SetKeyValue("SpawnFrequency", "15")
	ents.FindByName("template_helicopter_maker_w4")[1]:SetKeyValue("MaxLiveChildren", "2")
	ents.FindByName("template_helicopter_maker_w4")[1]:SetKeyValue("MaxNPCCount", "3")

	ents.FindByName("template_gunner_maker")[1]:SetKeyValue("SpawnFrequency", "20")
	ents.FindByName("template_gunner_maker")[1]:SetKeyValue("MaxLiveChildren", "2")
	ents.FindByName("template_gunner_maker")[1]:SetKeyValue("MaxNPCCount", "3")
	ents.FindByName("template_gunner_maker_w4")[1]:SetKeyValue("SpawnFrequency", "15")
	ents.FindByName("template_gunner_maker_w4")[1]:SetKeyValue("MaxLiveChildren", "3")
	ents.FindByName("template_gunner_maker_w4")[1]:SetKeyValue("MaxNPCCount", "5")
end