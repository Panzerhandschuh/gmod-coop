-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(30, "buckshot", true)
	end )
end

-- Adjust spawners to be less annoying
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker") then
		local count = tonumber(v)
		if (k == "MaxNPCCount") then
			if (count >= 40) then
				return math.Round(count * 0.5)
			elseif (count >= 20) then
				return math.Round(count * 0.75)
			else
				return v
			end
		end
	elseif (e:GetClass() == "npc_maker") then
		if (k == "NPCType" && v == "npc_antlionworker") then
			return "npc_antlion"
		end
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("s1")[1]:SetPos(Vector(-3680, -368, 64))
	ents.FindByName("sn2")[1]:SetPos(Vector(-3680, 1105, 64))

	local r1 = ents.Create("weapon_rpg")
	r1:SetPos(Vector(-3453, 378, -91))
	r1:SetAngles(Angle(0, 0, 0))
	r1.ei = 0.1
	r1.oPos = Vector(-3453, 378, -91)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()
	
	local r2 = ents.Create("weapon_rpg")
	r2:SetPos(Vector(-3453, 410, -91))
	r2:SetAngles(Angle(0, 0, 0))
	r2.ei = 0.2
	r2.oPos = Vector(-3453, 410, -91)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
	
	local r3 = ents.Create("weapon_rpg")
	r3:SetPos(Vector(-3453, 346, -91))
	r3:SetAngles(Angle(0, 0, 0))
	r3.ei = 0.3
	r3.oPos = Vector(-3453, 346, -91)
	r3.oAng = Angle(0, 0, 0)
	r3:Spawn()
end