AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

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

local ITEM_TO_AMOUNT = {}
ITEM_TO_AMOUNT["item_ammo_357"] = 6
ITEM_TO_AMOUNT["item_ammo_357_large"] = 20
ITEM_TO_AMOUNT["item_ammo_ar2"] = 20
ITEM_TO_AMOUNT["item_ammo_ar2_large"] = 60
ITEM_TO_AMOUNT["item_ammo_ar2_altfire"] = 1
ITEM_TO_AMOUNT["item_ammo_crossbow"] = 6
ITEM_TO_AMOUNT["item_ammo_pistol"] = 20
ITEM_TO_AMOUNT["item_ammo_pistol_large"] = 100
ITEM_TO_AMOUNT["item_ammo_smg1"] = 45
ITEM_TO_AMOUNT["item_ammo_smg1_large"] = 225
ITEM_TO_AMOUNT["item_ammo_smg1_grenade"] = 1
ITEM_TO_AMOUNT["item_box_buckshot"] = 20
ITEM_TO_AMOUNT["item_rpg_round"] = 1

local WEP_CLIP_SIZE = {}
WEP_CLIP_SIZE["weapon_357"] = 6
WEP_CLIP_SIZE["weapon_ar2"] = 30
WEP_CLIP_SIZE["weapon_crossbow"] = 1
WEP_CLIP_SIZE["weapon_pistol"] = 18
WEP_CLIP_SIZE["weapon_rpg"] = 3
WEP_CLIP_SIZE["weapon_shotgun"] = 6
WEP_CLIP_SIZE["weapon_smg1"] = 45
WEP_CLIP_SIZE["weapon_frag"] = 1

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
		local itemAmmo = ITEM_TO_AMOUNT[itemClass]
		local currentAmmo = ply:GetAmmoCount(ammo)
		if currentAmmo >= maxAmmo then
			return false
		elseif currentAmmo + itemAmmo > maxAmmo then
			ply:SetAmmo(maxAmmo - itemAmmo, ammo)
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
			timer.Create("respawn_"..ei, 10, 1, function() RespawnEnt(itemClass,ei,pos,ang) end)
		end
	end
end

function GM:PlayerCanPickupWeapon(ply, wep)
	local wepClass = wep:GetClass()
	local ammo = WEP_TO_AMMO[wepClass]
	if !ammo then -- Weapon does not have ammo
		if ply:HasWeapon(wepClass) then -- Do not pickup the item if the player already has it
			return false
		else -- Player does not have this weapon, so equip it and duplicate if possible
			TryDuplicateWeapon(wep, wepClass)
			return true
		end
	end
	
	local maxAmmo = MAX_AMMO[ammo]
	local clipSize = WEP_CLIP_SIZE[wepClass]
	local currentAmmo = ply:GetAmmoCount(ammo)
	
	if !ply:HasWeapon(wepClass) then
		-- Check ammo capacity
		if currentAmmo + clipSize > maxAmmo then
			ply:SetAmmo(maxAmmo - clipSize, ammo)
		end
		
		TryDuplicateWeapon(wep, wepClass)
		return true
	end
	
	if WEP_TO_AMMO[wepClass] then -- Weapon exists in conversion table
		-- Check ammo capacity
		if currentAmmo >= maxAmmo then
			return false
		elseif currentAmmo + clipSize > maxAmmo then
			ply:SetAmmo(maxAmmo - clipSize, ammo)
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
			timer.Create("respawn_"..ei, 10, 1, function() RespawnEnt(wepClass,ei,pos,ang) end)
		end
	end
end