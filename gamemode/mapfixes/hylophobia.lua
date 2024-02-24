-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_crowbar")
		ply:Give("weapon_pistol")
		
		ply:GiveAmmo(80, "pistol", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_template_maker" || e:GetClass() == "npc_maker") then
		if (k == "MaxNPCCount") then
			return math.Round(v * 4)
		elseif (k == "MaxLiveChildren") then
			return math.Round(v * 2)
		end
	end
end

HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(6556, -5576, 1296)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,25,-1",0)
		end
	end
	
	local npc1 = ents.Create("npc_turret_ceiling")
	npc1:SetKeyValue("SpawnFlags", "32")
	npc1:SetKeyValue("Origin", "4308.4375 8436.625 1734")
    npc1:Spawn()
end