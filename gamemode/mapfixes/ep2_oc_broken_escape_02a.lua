-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")		

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(12, "buckshot", true)
		ply:GiveAmmo(30, "ar2", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "weaponbox_template" && k == "spawnflags") then
		return "3"
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("weaponbox_template")[1]:Remove()
	-- ents.FindByName("relay_combineshieldwall1_off")[1]:Remove()
	ents.FindByName("turret_1_model")[1]:Remove()
	-- ents.FindByName("clip_combineshieldwall1")[1]:Remove()
	-- ents.FindByName("brush_combineshieldwall1")[1]:Remove()
	-- ents.FindByName("clip_combineshieldwall2")[1]:Remove()
	-- ents.FindByName("brush_combineshieldwall2")[1]:Remove()
	ents.FindByName("ballspawner_ballgenerator1")[1]:Remove()
	
	local r1 = ents.Create("weapon_rpg")
	r1:SetPos(Vector(-95, -3364, -70))
	r1:SetAngles(Angle(0, 0, 0))
	r1.ei = 0.1
	r1.oPos = Vector(-95, -3364, -70)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()

	local r2 = ents.Create("weapon_rpg")
	r2:SetPos(Vector(-95, -3364, -70))
	r2:SetAngles(Angle(0, 0, 0))
	r2.ei = 0.2
	r2.oPos = Vector(-95, -3364, -70)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
end