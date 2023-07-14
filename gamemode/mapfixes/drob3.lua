local toggleSpawn = false

-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_ar2")
		ply:Give("weapon_crossbow")
		ply:Give("weapon_rpg")

		ply:GiveAmmo(90, "smg1", true)
		ply:GiveAmmo(90, "ar2", true)
		ply:GiveAmmo(20, "xbowbolt", true)

		if (toggleSpawn) then
			local spawnPos = ents.FindByName("robossTrain")[1]:GetPos()
			spawnPos[3] = spawnPos[3] - 64
			ply:SetPos(spawnPos)
		end
	end )
end

HOOKS["AcceptInput"] = function(e,i,a,c,v)
	if (e:GetName() == "robossStartButton" && i == "Use") then
		toggleSpawn = true
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_changelevel" && k == "map" && v == "drob2") then
		e:Remove()
	elseif (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 4)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	timer.Simple(45, function()
		ents.FindByName("hangarHurtLeft")[1]:Input("Break")
		ents.FindByName("hangarHurtRight")[1]:Input("Break")
	end)
end