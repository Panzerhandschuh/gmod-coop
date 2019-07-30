AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("spectate.lua")
AddCSLuaFile("newstam.lua")
AddCSLuaFile("rtv/config.lua")
AddCSLuaFile("rtv/cl_rtv.lua")
AddCSLuaFile("timer.lua")

include("sv_mapseries.lua")
include("shared.lua")
include("spectate.lua")
include("sv_adverts.lua")
include("rtv/sv_rtv.lua")
include("sv_syntruck.lua")

local isOC = false
if(string.find(game.GetMap(),"oc_")) then
	isOC = true
end

local function AddContent(dir)
	local f,d = file.Find("gamemodes/coop/content/"..dir.."*","MOD")

	for k,v in pairs(f) do
		resource.AddSingleFile(dir..v)
	end

	for k,v in pairs(d) do
		AddContent(dir..""..v.."/")
	end
end

AddContent("")

local ITEM_RESPAWN_TIME = 10
local WEAPON_RESPAWN_TIME = 6

local MAX_AMMO = {}
MAX_AMMO["pistol"] = 150
MAX_AMMO["357"] = 18
MAX_AMMO["smg1"] = 225
MAX_AMMO["smg1_grenade"] = 3
MAX_AMMO["ar2"] = 60
MAX_AMMO["ar2altfire"] = 3
MAX_AMMO["buckshot"] = 30
MAX_AMMO["xbowbolt"] = 10
MAX_AMMO["rpg_round"] = 3
MAX_AMMO["grenade"] = 5
MAX_AMMO["slam"] = 5

local ITEM_TO_AMMO = {}
ITEM_TO_AMMO["item_ammo_357"] = "357"
ITEM_TO_AMMO["item_ammo_357_large"] = "357"
ITEM_TO_AMMO["item_ammo_ar2"] = "ar2"
ITEM_TO_AMMO["item_ammo_ar2_large"] = "ar2"
ITEM_TO_AMMO["item_ammo_ar2_altfire"] = "ar2altfire"
ITEM_TO_AMMO["item_ammo_crossbow"] = "xbowbolt"
ITEM_TO_AMMO["item_ammo_pistol"] = "pistol"
ITEM_TO_AMMO["item_ammo_pistol_large"] = "pistol"
ITEM_TO_AMMO["item_ammo_smg1"] = "smg1"
ITEM_TO_AMMO["item_ammo_smg1_large"] = "smg1"
ITEM_TO_AMMO["item_ammo_smg1_grenade"] = "smg1_grenade"
ITEM_TO_AMMO["item_box_buckshot"] = "buckshot"
ITEM_TO_AMMO["item_rpg_round"] = "rpg_round"

local WEP_TO_AMMO = {}
WEP_TO_AMMO["weapon_357"] = "357"
WEP_TO_AMMO["weapon_ar2"] = "ar2"
WEP_TO_AMMO["weapon_crossbow"] = "xbowbolt"
WEP_TO_AMMO["weapon_pistol"] = "pistol"
WEP_TO_AMMO["weapon_rpg"] = "rpg_round"
WEP_TO_AMMO["weapon_shotgun"] = "buckshot"
WEP_TO_AMMO["weapon_smg1"] = "smg1"
WEP_TO_AMMO["weapon_frag"] = "grenade"
WEP_TO_AMMO["weapon_slam"] = "slam"

local AMMONUM_TO_STRING = {}
AMMONUM_TO_STRING[1] = "ar2"
AMMONUM_TO_STRING[2] = "ar2altfire"
AMMONUM_TO_STRING[3] = "pistol"
AMMONUM_TO_STRING[4] = "smg1"
AMMONUM_TO_STRING[5] = "357"
AMMONUM_TO_STRING[6] = "xbowbolt"
AMMONUM_TO_STRING[7] = "buckshot"
AMMONUM_TO_STRING[8] = "rpg_round"
AMMONUM_TO_STRING[9] = "smg1_grenade"
AMMONUM_TO_STRING[10] = "grenade"
AMMONUM_TO_STRING[11] = "slam"

local WEAPON_RANDOM = {}
WEAPON_RANDOM[1] = "weapon_357"
WEAPON_RANDOM[2] = "weapon_ar2"
WEAPON_RANDOM[3] = "weapon_crossbow"
WEAPON_RANDOM[4] = "weapon_pistol"
WEAPON_RANDOM[5] = "weapon_shotgun"
WEAPON_RANDOM[6] = "weapon_smg1"

local ITEM_RANDOM = {}
ITEM_RANDOM[1] = "item_ammo_357_large"
ITEM_RANDOM[2] = "item_ammo_ar2_large"
ITEM_RANDOM[3] = "item_ammo_crossbow"
ITEM_RANDOM[4] = "item_ammo_pistol_large"
ITEM_RANDOM[5] = "item_ammo_smg1_large"
ITEM_RANDOM[6] = "item_box_buckshot"

local REPLACE_ENTS = {}
REPLACE_ENTS["weapon_mp5k"] = "weapon_smg1"
REPLACE_ENTS["weapon_mg1"] = "weapon_ar2"
REPLACE_ENTS["weapon_sl8"] = "weapon_ar2"
REPLACE_ENTS["weapon_sniperrifle"] = "weapon_crossbow"
REPLACE_ENTS["weapon_uzi"] = "weapon_smg1"
REPLACE_ENTS["weapon_gauss"] = "weapon_smg1"
REPLACE_ENTS["weapon_deagle"] = "weapon_357"
REPLACE_ENTS["weapon_medkit"] = "item_healthkit"
REPLACE_ENTS["npc_gargantua"] = "monster_gargantua"
REPLACE_ENTS["npc_alien_grunt"] = "monster_alien_grunt"
REPLACE_ENTS["npc_hassassin"] = "monster_human_assassin"
REPLACE_ENTS["npc_houndeye"] = "monster_houndeye"
REPLACE_ENTS["npc_bullsquid"] = "monster_bullchicken"
REPLACE_ENTS["npc_hgrunt"] = "npc_combine_s"
REPLACE_ENTS["npc_defender"] = "npc_hunter"
REPLACE_ENTS["monster_bigmomma"] = "npc_antlionguard"
REPLACE_ENTS["item_box_sl8_rounds"] = "item_ammo_ar2_large"
REPLACE_ENTS["item_box_sniper_rounds"] = "item_ammo_crossbow"
REPLACE_ENTS["item_ammo_tau"] = "item_ammo_smg1_large"
REPLACE_ENTS["weapon_scripted"] = "WEAPON_RANDOM"
REPLACE_ENTS["item_custom"] = "ITEM_RANDOM"

local NPC_POINTS = {}
NPC_POINTS["npc_antlion"] = 2
NPC_POINTS["npc_antlionguard"] = 8
NPC_POINTS["npc_barnacle"] = 1
NPC_POINTS["npc_citizen"] = -5
NPC_POINTS["npc_manhack"] = 1
NPC_POINTS["npc_rollermine"] = 2
NPC_POINTS["npc_stalker"] = 2
NPC_POINTS["npc_metropolice"] = 2
NPC_POINTS["npc_combine_s"] = 3
NPC_POINTS["npc_sniper"] = 4
NPC_POINTS["npc_hunter"] = 5
NPC_POINTS["npc_strider"] = 10
NPC_POINTS["npc_combinegunship"] = 12
NPC_POINTS["npc_helicopter"] = 15
NPC_POINTS["npc_headcrab"] = 1
NPC_POINTS["npc_headcrab_black"] = 1
NPC_POINTS["npc_headcrab_fast"] = 1
NPC_POINTS["npc_zombie"] = 2
NPC_POINTS["npc_zombie_torso"] = 1
NPC_POINTS["npc_zombine"] = 3
NPC_POINTS["npc_fastzombie"] = 2
NPC_POINTS["npc_fastzombie_torso"] = 1
NPC_POINTS["npc_poisonzombie"] = 3
NPC_POINTS["npc_ichthyosaur"] = 5
NPC_POINTS["npc_turret_ceiling"] = 5
NPC_POINTS["npc_turret_floor"] = 2
NPC_POINTS["npc_turret_ground"] = 2
NPC_POINTS["npc_vortigaunt"] = 4
NPC_POINTS["monster_gargantua"] = 10
NPC_POINTS["monster_alien_grunt"] = 3
NPC_POINTS["monster_human_assassin"] = 3
NPC_POINTS["monster_houndeye"] = 1
NPC_POINTS["monster_bullchicken"] = 2

for k,_ in pairs(REPLACE_ENTS) do
	if(string.sub(k,1,4) != "npc_" && string.sub(k,1,8) != "monster_" && k != "weapon_medkit") then
		scripted_ents.Register({Type="point"}, k, false)
	end
end

scripted_ents.Register({Type="anim"}, "info_waypoint", false)
scripted_ents.Register({Type="brush", Base="base_brush"}, "trigger_once_oc", false)
scripted_ents.Register({Type="brush", Base="base_brush"}, "trigger_multiple_oc", false)

GM.RefreshOCSpawn = false

local rebelmaps = {
	"js_build_puzzle1_ob",
	"js_build_puzzle2_ob",
	"js_build_puzzle3_ob",
	"js_build_puzzle4_ob",
	"js_build_puzzle5_ob",
	"js_build_puzzle6_ob",
	"js_build_puzzle7_ob",
	"js_build_puzzle8_ob",
	"js_build_puzzle9_ob_r1",
	"js_build_puzzle10_ob_v4",
	"js_build_puzzle_eleven_v7",
	"js_build_puzzle12_ob",
	"js_build_puzzle13_ob",
	"js_build_puzzle14_ob1",
	"js_build_puzzle_fifteen_v5a",
	"js_build_puzzle_sixteen_v5c",
	"js_build_puzzle_seventeen_v5e",
	"js_build_puzzle_eighteen_v2",
	"js_build_puzzle19_ob",
	"poison_puzzle_aztec_v6",
	"poison_puzzle_base_v1",
	"poison_puzzle_christmas_beta2",
	"poison_puzzle_lego_v2",
	"mph_puzzle_one_v4",
	"mph_twilight_v3",
	"dr_puzzle_mario_final",
	"ow_puzzleoflove_one_v10",
	"puzlehl2",
	"coop_port_sg_zb",
	"mph_crane_hop_v4",
	"z_harrier_b",
	"z_harrier2_f",
	"coop_citadel_escape_p6",
	"coop_citadel_escape_v2fix",
	"coop_mushroomcaves_v1",
	"mph_citadel_escape_z1_test",
	"js_coop_powerworks_v2",
	"js_coop_monsterkill_reload_b",
	"poison_coop_re1_beta1",
	"tbr_coop_red_keops_v4"
}

function GM:Initialize()
	local s = scripted_ents.Get("info_player_deathmatch")
	s.KeyValue = function(self, key, value)
		if(key == "StartDisabled" && tonumber(value) == 1) then
			self.disabled = true
		end
	end
	
	s.AcceptInput = function(self, inputName, activator, called, data)
		if(inputName == "Enable") then
			self.disabled = false
			GAMEMODE.RefreshOCSpawn = true
		elseif(inputName == "Disable") then
			self.disabled = true
			GAMEMODE.RefreshOCSpawn = true
		end
	end
	scripted_ents.Register(s,"info_player_deathmatch")
end

function GM:PlayerInitialSpawn(ply)
	local t = #player.GetAll()
	for k,v in pairs(ents.FindByClass("trigger_coop")) do
		if(v.percentage) then
			v:UpdatePlayerCount(t)
		end
	end
	
	if(!TIMER.start) then TIMER:Start() end
	
	self.BaseClass:PlayerInitialSpawn(ply)
end

function GM:PlayerPostThink(ply)
	if(self.RespawnJeep) then
		if(ply.CurrentJeep) then
			local j = ply.CurrentJeep
			if(j:GetPos():DistToSqr(ply:GetPos()) >= 4000000) then --2000 units away
				if(j.spawner) then
					j.spawner.JeepCount = j.spawner.JeepCount - 1
				end
				j:Remove()
				ply.CurrentJeep = nil
			end
		end
	end
	
	self.BaseClass:PlayerPostThink(ply)
end

function GM:CanPlayerEnterVehicle(ply,vehicle,role)
	if(self.RespawnJeep && (vehicle:GetClass() == "prop_vehicle_jeep" || vehicle:GetClass() == "prop_vehicle_airboat") && vehicle.IsOwned) then
		return false
	end
	
	return self.BaseClass:CanPlayerEnterVehicle(ply,vehicle,role)
end

function GM:PlayerEnteredVehicle(ply,vehicle,role)
	if(self.RespawnJeep && (vehicle:GetClass() == "prop_vehicle_jeep" || vehicle:GetClass() == "prop_vehicle_airboat")) then
		vehicle.IsOwned = true
		ply.CurrentJeep = vehicle
	end
	
	self.BaseClass:PlayerEnteredVehicle(ply,vehicle,role)
end

function GM:PlayerLeaveVehicle(ply,vehicle)
	if(self.RespawnJeep && (vehicle:GetClass() == "prop_vehicle_jeep" || vehicle:GetClass() == "prop_vehicle_airboat")) then
		vehicle.IsOwned = false
	end
	
	self.BaseClass:PlayerLeaveVehicle(ply,vehicle)
end

function GM:PlayerDisconnected(ply)
	local t = #player.GetAll()
	for k,v in pairs(ents.FindByClass("trigger_coop")) do
		if(v.percentage) then
			v:UpdatePlayerCount(t)
		end
	end
	for k,v in pairs(ents.FindByClass("trigger_player_count")) do --it wont affect if it is a connect
		v:UpdatePlayerCount(t)
	end
	
	self.BaseClass:PlayerDisconnected(ply)
end

function GM:PlayerSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_coop")
	
	-- Try equipping player
	timer.Simple(0.1, function()
		for k,v in pairs(ents.FindByClass("info_player_equip")) do
			v:Input("equipplayer", ply, nil)
		end
	end)

	self.BaseClass:PlayerSpawn(ply)
	
	ply:SetCustomCollisionCheck(true)
end

function GM:InitPostEntity()
	for k,v in pairs(ents.FindByClass("trigger_multiple_oc")) do
		local ne = ents.Create("trigger_multiple")
		ne:SetPos(v:GetPos())
		ne:SetAngles(v:GetAngles())
		ne:SetName(v:GetName())
		ne:SetModel(v:GetModel())
		ne:SetKeyValue("spawnflags", v.spf)
		if(v.wa) then
			ne:SetKeyValue("wait", v.wa)
		end
		if(v.dis) then
			ne:SetKeyValue("StartDisabled", v.dis)
		end
		if (v.filter) then
			ne:SetKeyValue("filtername", v.filter) -- Leaving in incase it has some relevance
		end
		if(v.oc_out) then
			for _,o in pairs(v.oc_out) do
				ne:Fire("AddOutput",o,0)
			end
		end
		ne:Spawn()
		if(v.filter) then
			ne:SetSaveValue("m_hFilter",ents.FindByName(v.filter)[1]) -- This really is blatent cheating lmao
		end
		v:Remove()
	end
	for k,v in pairs(ents.FindByClass("trigger_once_oc")) do
		local ne = ents.Create("trigger_once")
		ne:SetPos(v:GetPos())
		ne:SetAngles(v:GetAngles())
		ne:SetName(v:GetName())
		ne:SetModel(v:GetModel())
		ne:SetKeyValue("spawnflags", v.spf)
		if(v.dis) then
			ne:SetKeyValue("StartDisabled", v.dis)
		end
		if (v.filter) then
			ne:SetKeyValue("filtername", v.filter)
		end
		if(v.oc_out) then
			for _,o in pairs(v.oc_out) do
				ne:Fire("AddOutput",o,0)
			end
		end
		ne:Spawn()
		if(v.filter) then
			ne:SetSaveValue("m_hFilter",ents.FindByName(v.filter)[1]) -- This really is blatent cheating lmao
		end
		v:Remove()
	end
	for k,v in pairs(ents.FindByClass("player_loadsaved")) do
		v:Remove()
	end
	for ent,replace in pairs(REPLACE_ENTS) do
		if(string.sub(ent,1,4) == "npc_" || string.sub(ent,1,8) == "monster_") then continue end
		for k,v in pairs(ents.FindByClass(ent)) do
			if(v:CreatedByMap()) then
				v:SetSolid(SOLID_NONE)
			
				-- Replace with random weapon or item
				local newEnt = replace
				local pos = v:GetPos()
				if (replace == "WEAPON_RANDOM") then
					math.randomseed(pos.x + pos.y + pos.z)
					local rand = math.random(1, table.Count(WEAPON_RANDOM))
					newEnt = WEAPON_RANDOM[rand]
				elseif (replace == "ITEM_RANDOM") then
					math.randomseed(pos.x + pos.y + pos.z)
					local rand = math.random(1, table.Count(ITEM_RANDOM))
					newEnt = ITEM_RANDOM[rand]
				end
				
				local ne = ents.Create(newEnt)
				ne:SetPos(pos)
				ne:SetAngles(v:GetAngles())
				ne:SetName(v:GetName())
				if(string.sub(ent,1,7) == "weapon_" || string.sub(ent,1,5) == "item_") then
					ne.oPos = v:GetPos()
					ne.oAng = v:GetAngles()
					ne.ei = v:EntIndex()
				end
					
				ne:Spawn()
				if(v.out) then
					for key,out in pairs(v.out) do
						ne:Fire("AddOutput",key.." "..out,0)
					end
				end
				v:Remove()
			end
		end
	end
	for k,v in pairs(ents.FindByClass("point_template")) do
		if(v:CreatedByMap()) then
			v:Respawn() --hopefully refreshes point_template?
		end
	end
	for k,v in pairs(ents.FindByClass("npc_turret_ceiling")) do
		v:SetHealth(350)
	end
	for k,v in pairs(ents.FindByClass("weapon_*")) do
		if(v:CreatedByMap()) then
			v:Spawn()
			v.oPos = v:GetPos()
			v.oAng = v:GetAngles()
			v.ei = v:EntIndex()
		end
	end
	for k,v in pairs(ents.FindByClass("item_health*")) do
		if(v:CreatedByMap()) then
			v.oPos = v:GetPos()
			v.oAng = v:GetAngles()
			v.ei = v:EntIndex()
		end
	end
	for k,v in pairs(ents.FindByClass("item_battery")) do
		if(v:CreatedByMap()) then
			v.oPos = v:GetPos()
			v.oAng = v:GetAngles()
			v.ei = v:EntIndex()
		end
	end
	for k,v in pairs(ents.FindByClass("item_ammo_*")) do
		if(v:CreatedByMap()) then
			v.oPos = v:GetPos()
			v.oAng = v:GetAngles()
			v.ei = v:EntIndex()
		end
	end
	for k,v in pairs(ents.FindByClass("item_box_buckshot")) do
		if(v:CreatedByMap()) then
			v.oPos = v:GetPos()
			v.oAng = v:GetAngles()
			v.ei = v:EntIndex()
		end
	end
	for k,v in pairs(ents.FindByClass("item_rpg_round")) do
		if(v:CreatedByMap()) then
			v.oPos = v:GetPos()
			v.oAng = v:GetAngles()
			v.ei = v:EntIndex()
		end
	end
end

local function RespawnEnt(ent,class,index,pos,ang,cmodel,amount,atype)
	if (IsValid(ent) && !IsValid(ent:GetOwner())) then -- Don't respawn entities that still exist (they should've been picked up and nullified)
		return
	end

	local e = ents.Create(class)
	e:SetPos(pos)
	e:SetAngles(ang)
	e.ei = index
	e.oPos = pos
	e.oAng = ang
	if(cmodel) then
		e.cmodel = cmodel
		e.AmmoAmount = amount
		e.AmmoType = atype
	end
	e:Spawn()
	e:EmitSound("weapons/stunstick/alyx_stunner2.wav")
end

function GM:PlayerShouldTakeDamage(ply, attacker)
	if (attacker:IsValid() && attacker:IsPlayer() && ply != attacker) then
		return false
	end
	return true
end

function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if (attacker:GetClass() == "npc_monk") then
		dmginfo:ScaleDamage(0.25)
	end
end

function GM:Think()
	-- Limit player ammmo
	for _, ply in pairs(player.GetAll()) do
		local wep = ply:GetActiveWeapon()
		if (wep == nil) then
			continue
		end
		
		-- Primary ammo
		if(wep.GetPrimaryAmmoType) then
			local ammoNum = wep:GetPrimaryAmmoType()
			CheckMaxAmmo(ply, wep, ammoNum)
		end
		
		-- Secondary ammo
		if(wep.GetSecondaryAmmoType) then
			ammoNum = wep:GetSecondaryAmmoType()
			CheckMaxAmmo(ply, wep, ammoNum)
		end
	end
end

function CheckMaxAmmo(ply, wep, ammoNum)
	if (ammoNum == -1) then
		return
	end
	
	local ammo = AMMONUM_TO_STRING[ammoNum]
	local maxAmmo = MAX_AMMO[ammo]
	local currentAmmo = ply:GetAmmoCount(ammo)
	if currentAmmo >= maxAmmo then
		ply:SetAmmo(maxAmmo, ammo)
	end
end

function GM:PlayerCanPickupItem(ply, item)
	local itemClass = item:GetClass()
	
	-- Check for health/suit items
	if (itemClass == "item_healthkit" || itemClass == "item_healthvial") then
		if (ply:Health() == 100) then
			return false
		else
			TryDuplicateItem(item, itemClass)
			return true
		end
	elseif (itemClass == "item_battery") then
		if (ply:Armor() == 100) then
			return false
		else
			TryDuplicateItem(item, itemClass)
			return true
		end
	end
	
	if(itemClass == "item_custom") then
		local ammo = item.AmmoType
		local maxAmmo = MAX_AMMO[string.lower(ammo)]
		local currentAmmo = ply:GetAmmoCount(ammo)
		if currentAmmo >= maxAmmo then
			return false
		end
	end
	
	-- Limit max ammo
	if (ITEM_TO_AMMO[itemClass] ~= nil) then -- Item exists in conversion table
		local ammo = ITEM_TO_AMMO[itemClass]
		local maxAmmo = MAX_AMMO[ammo]
		local currentAmmo = ply:GetAmmoCount(ammo)
		if currentAmmo >= maxAmmo then
			return false
		end
	end
		
	TryDuplicateItem(item, itemClass)
	return true
end

function TryDuplicateItem(item, itemClass)
	if(item.ei) then
		local ei = item.ei
		local pos = item.oPos
		local ang = item.oAng
		local cmodel, amount, atype
		if(item.cmodel) then
			cmodel = item.cmodel
			amount = item.AmmoAmount
			atype = item.AmmoType
		end
		if(!timer.Exists("respawn_"..ei)) then
			timer.Create("respawn_"..ei, ITEM_RESPAWN_TIME, 1, function() RespawnEnt(item,itemClass,ei,pos,ang,cmodel,amount,atype) end)
		end
	end
end

function GM:PlayerCanPickupWeapon(ply, wep)
	local wepClass = wep:GetClass()
	local ammo = WEP_TO_AMMO[wepClass]
	if !ammo then -- Weapon type does not have ammo (crowbar, grav gun, etc)
		if ply:HasWeapon(wepClass) then -- Do not pickup the item if the player already has it
			return false
		else -- Player does not have this weapon, so equip it and duplicate if possible
			TryDuplicateWeapon(wep, wepClass)
			return true
		end
	end
	
	local maxAmmo = MAX_AMMO[ammo]
	local currentAmmo = ply:GetAmmoCount(ammo)
	
	-- Pickup new weapon
	if !ply:HasWeapon(wepClass) then
		TryDuplicateWeapon(wep, wepClass)
		return true
	end
	
	if WEP_TO_AMMO[wepClass] then -- Weapon exists in conversion table
		-- Check ammo capacity
		if currentAmmo >= maxAmmo then
			return false
		end
	end
	
	TryDuplicateWeapon(wep, wepClass)
	return true
end

function TryDuplicateWeapon(wep, wepClass)
	if (wep.ei) then
		local ei = wep.ei
		local pos = wep.oPos
		local ang = wep.oAng
		if(!timer.Exists("respawn_"..ei)) then
			timer.Create("respawn_"..ei, WEAPON_RESPAWN_TIME, 1, function() RespawnEnt(wep,wepClass,ei,pos,ang) end)
		end
	end
end

function GM:OnEntityCreated( ent )
		local class = ent:GetClass()
		if(REPLACE_ENTS[class] && (string.sub(class,1,4) == "npc_" || string.sub(class,1,8) == "monster_")) then
			timer.Simple(0.1,function()
				if(ent:IsValid()) then
					ent:SetSolid(SOLID_NONE)
					local ne = ents.Create(REPLACE_ENTS[class])
					ne:SetPos(ent:GetPos())
					ne:SetAngles(ent:GetAngles())
					
					if(game.GetMap() == "oc_zelda02_g") then
						ne:SetName("replaced_npc")
					else
						ne:SetName(ent:GetName())
					end
					
					for key,value in pairs(ent:GetKeyValues()) do
						if(key != "classname" && string.sub(key,1,2) != "On" && type(value) == "string") then
							ne:SetKeyValue(key,value)
						end
					end
				
					ne:Spawn()
					
					if(ent.chealth) then
						ne:SetHealth(ent.chealth)
					end
					
					if(ent.out) then
						for k,v in pairs(ent.out) do
							--PrintMessage( HUD_PRINTCONSOLE, "Added Output "..k.." "..v)
							ne:Fire("AddOutput",k.." "..v,0)
						end
					end

					ent:Remove()
				end
			end)
		elseif(string.sub(class,1,4) == "npc_" || string.sub(class,1,8) == "monster_") then
			timer.Simple(0.1,function()
				if(ent:IsValid()) then
					if(ent.chealth) then
						ent:SetHealth(ent.chealth)
					end
				end
			end)
		end
end

local randselect = {
	"weapon_shotgun",
	"weapon_ar2",
	"weapon_smg1",
	"weapon_pistol"
}

local puzzleCount = 0

function GM:AcceptInput(ent, input, activator, caller, value)
	-- Puzzle manager
	if (ent.requiredPuzzles && string.lower(input) == "add") then
		puzzleCount = puzzleCount + 1
		PrintMessage(HUD_PRINTTALK, "[Puzzle Manager] Completed " .. puzzleCount .. "/" .. ent.requiredPuzzles .. " required puzzles.")
		if (puzzleCount == ent.requiredPuzzles) then
			PrintMessage(HUD_PRINTTALK, "[Puzzle Manager] All required puzzles have been completed!")
		end
	end
end

function GM:EntityKeyValue(e,k,v)
	if(string.sub(k,1,2) == "On") then
		if(REPLACE_ENTS[e:GetClass()] && (string.sub(e:GetClass(),1,4) == "npc_" || string.sub(e:GetClass(),1,8) == "monster_")) then
			if(!e.out) then e.out = {} end
			--PrintMessage( HUD_PRINTCONSOLE, "Found Output "..k.." "..v)
			e.out[k] = v
		end
	end
	if(isOC && k == "health" && (string.sub(e:GetClass(),1,4) == "npc_" || string.sub(e:GetClass(),1,8) == "monster_")) then
		e.chealth = tonumber(v)
	end
	if(e:GetClass() == "trigger_multiple_oc" || e:GetClass() == "trigger_once_oc") then
		if(string.sub(k,1,2) == "On") then
			if(!e.oc_out) then e.oc_out = {} end
			table.insert(e.oc_out,k.." "..v)
		elseif(k == "spawnflags") then
			e.spf = v
		elseif(k == "wait") then
			e.wa = v
		elseif(k == "StartDisabled") then
			e.dis = v
		elseif(k == "filtername") then
			e.filter = v
		end
	elseif((e:GetClass() == "info_player_coop" || e:GetClass() == "info_player_start") && k == "StartDisabled") then
		if(tonumber(v) == 1) then
			e.disabled = true
		end
	elseif(e:GetClass() == "info_waypoint" && k == "text") then
		e:SetNetworkedString("text", v)
	elseif(e:GetClass() == "prop_vehicle_jeep" && k == "model") then
		return "models/buggy.mdl"
	end
	if(k == "NPCType" && REPLACE_ENTS[v]) then
		return REPLACE_ENTS[v]
	end
	if(k == "additionalequipment") then
		if(REPLACE_ENTS[v]) then
			return REPLACE_ENTS[v]
		end
		if(string.sub(v,1,7) == "custom_") then
			return "weapon_smg1"
		end
		if(v == "random") then
			return table.Random(randselect)
		end
	end
end

function GM:PlayerSelectSpawn( pl )
	if(self.currentspawn) then
		return self.currentspawn
	end
	
	-- Save information about all of the spawn points
	-- in a team based game you'd split up the spawns
	if ( !IsTableOfEntitiesValid( self.SpawnPoints ) ) then
	
		self.LastSpawnPoint = 0
		self.SpawnPoints = {}
		for k,v in pairs(ents.FindByClass( "info_player_deathmatch" )) do
			if(!v.disabled) then
				table.insert(self.SpawnPoints,v)
			end
		end
		if(!table.HasValue(rebelmaps,game.GetMap())) then
			self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		end
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )
		for k,v in pairs(ents.FindByClass( "info_player_coop" )) do
			if(!v.disabled) then
				table.insert(self.SpawnPoints,v)
			end
		end
		if(table.Count(self.SpawnPoints) == 0) then
			for k,v in pairs(ents.FindByClass( "info_player_start" )) do
				if(!v.disabled) then
					table.insert(self.SpawnPoints,v)
				end
			end
		end
	elseif(self.RefreshOCSpawn) then
		for k,v in pairs(ents.FindByClass("info_player_deathmatch")) do
			if(v.disabled) then
				table.RemoveByValue(self.SpawnPoints, v)
			else
				table.insert(self.SpawnPoints, v)
			end
		end
		for k,v in pairs(ents.FindByClass("info_player_start")) do
			if(v.disabled) then
				table.RemoveByValue(self.SpawnPoints, v)
			else
				table.insert(self.SpawnPoints, v)
			end
		end
		self.RefreshOCSpawn = false
	end
	
	local Count = table.Count( self.SpawnPoints )
	
	if ( Count == 0 ) then
		Msg("[PlayerSelectSpawn] Error! No spawn points!\n")
		return nil
	end
	
	-- If any of the spawnpoints have a MASTER flag then only use that one.
	-- This is needed for single player maps.
	for k, v in pairs( self.SpawnPoints ) do
		
		if ( v:HasSpawnFlags( 1 ) ) then
			return v
		end
		
	end
	
	local ChosenSpawnPoint = nil
	
	-- Try to work out the best, random spawnpoint
	for i=0, Count do
	
		ChosenSpawnPoint = table.Random( self.SpawnPoints )

		if ( ChosenSpawnPoint &&
			ChosenSpawnPoint:IsValid() &&
			ChosenSpawnPoint:IsInWorld() &&
			ChosenSpawnPoint != pl:GetVar( "LastSpawnpoint" ) &&
			ChosenSpawnPoint != self.LastSpawnPoint ) then
			
			self.LastSpawnPoint = ChosenSpawnPoint
			pl:SetVar( "LastSpawnpoint", ChosenSpawnPoint )
			return ChosenSpawnPoint
			
		end
			
	end
	
	return ChosenSpawnPoint
	
end

function GM:GravGunOnPickedUp(ply, ent)
	if (ent:GetClass() == "npc_turret_floor") then
		for _, pl in pairs(player.GetAll()) do
			ent:AddEntityRelationship(pl, D_NU, 99)
		end
	end
end

function GM:OnNPCKilled(npc, attacker, inflictor)
	if (!attacker:IsValid() || !attacker:IsPlayer()) then
		return
	end
	
	local points = NPC_POINTS[npc:GetClass()]
	if (points) then
		attacker:AddFrags(points)
	end
	
	self.BaseClass:OnNPCKilled(npc, attacker, inflictor)
end