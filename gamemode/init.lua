AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local ITEM_RESPAWN_TIME = 10

local MAX_AMMO = {}
MAX_AMMO["Pistol"] = 150
MAX_AMMO["357"] = 12
MAX_AMMO["SMG1"] = 225
MAX_AMMO["SMG1_Grenade"] = 3
MAX_AMMO["AR2"] = 60
MAX_AMMO["AR2AltFire"] = 3
MAX_AMMO["Buckshot"] = 30
MAX_AMMO["XBowBolt"] = 10
MAX_AMMO["RPG_Round"] = 3
MAX_AMMO["Grenade"] = 5
MAX_AMMO["slam"] = 5

local ITEM_TO_AMMO = {}
ITEM_TO_AMMO["item_ammo_357"] = "357"
ITEM_TO_AMMO["item_ammo_357_large"] = "357"
ITEM_TO_AMMO["item_ammo_ar2"] = "AR2"
ITEM_TO_AMMO["item_ammo_ar2_large"] = "AR2"
ITEM_TO_AMMO["item_ammo_ar2_altfire"] = "AR2AltFire"
ITEM_TO_AMMO["item_ammo_crossbow"] = "XBowBolt"
ITEM_TO_AMMO["item_ammo_pistol"] = "Pistol"
ITEM_TO_AMMO["item_ammo_pistol_large"] = "Pistol"
ITEM_TO_AMMO["item_ammo_smg1"] = "SMG1"
ITEM_TO_AMMO["item_ammo_smg1_large"] = "SMG1"
ITEM_TO_AMMO["item_ammo_smg1_grenade"] = "SMG1_Grenade"
ITEM_TO_AMMO["item_box_buckshot"] = "Buckshot"
ITEM_TO_AMMO["item_rpg_round"] = "RPG_Round"

local WEP_TO_AMMO = {}
WEP_TO_AMMO["weapon_357"] = "357"
WEP_TO_AMMO["weapon_ar2"] = "AR2"
WEP_TO_AMMO["weapon_crossbow"] = "XBowBolt"
WEP_TO_AMMO["weapon_pistol"] = "Pistol"
WEP_TO_AMMO["weapon_rpg"] = "RPG_Round"
WEP_TO_AMMO["weapon_shotgun"] = "Buckshot"
WEP_TO_AMMO["weapon_smg1"] = "SMG1"
WEP_TO_AMMO["weapon_frag"] = "Grenade"
WEP_TO_AMMO["weapon_slam"] = "slam"

local AMMONUM_TO_STRING = {}
AMMONUM_TO_STRING[1] = "AR2"
AMMONUM_TO_STRING[2] = "AR2AltFire"
AMMONUM_TO_STRING[3] = "Pistol"
AMMONUM_TO_STRING[4] = "SMG1"
AMMONUM_TO_STRING[5] = "357"
AMMONUM_TO_STRING[6] = "XBowBolt"
AMMONUM_TO_STRING[7] = "Buckshot"
AMMONUM_TO_STRING[8] = "RPG_Round"
AMMONUM_TO_STRING[9] = "SMG1_Grenade"
AMMONUM_TO_STRING[10] = "Grenade"
AMMONUM_TO_STRING[11] = "slam"

function GM:PlayerSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_coop")

	self.BaseClass:PlayerSpawn(ply)
end

function GM:InitPostEntity()
	for k,v in pairs(ents.FindByClass("weapon_*")) do
		if(v:CreatedByMap()) then
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

local function RespawnEnt(class,index,pos,ang)
	local e = ents.Create(class)
	e:SetPos(pos)
	e:SetAngles(ang)
	e.ei = index
	e.oPos = pos
	e.oAng = ang
	e:Spawn()
	e:EmitSound("weapons/stunstick/alyx_stunner2.wav")
end

function GM:PlayerShouldTakeDamage(ply, attacker)
	if (attacker:IsValid() && attacker:IsPlayer() && ply != attacker) then
		return false
	end
	return true
end

function GM:Think()
	-- Limit player ammmo
	for _, ply in pairs(player.GetAll()) do
		local wep = ply:GetActiveWeapon()
		if (wep == nil) then
			continue
		end
		
		-- Primary ammo
		local ammoNum = wep:GetPrimaryAmmoType()
		CheckMaxAmmo(ply, wep, ammoNum)
		
		-- Secondary ammo
		ammoNum = wep:GetSecondaryAmmoType()
		CheckMaxAmmo(ply, wep, ammoNum)
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
		if(!timer.Exists("respawn_"..ei)) then
			timer.Create("respawn_"..ei, ITEM_RESPAWN_TIME, 1, function() RespawnEnt(itemClass,ei,pos,ang) end)
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
			timer.Create("respawn_"..ei, ITEM_RESPAWN_TIME, 1, function() RespawnEnt(wepClass,ei,pos,ang) end)
		end
	end
end