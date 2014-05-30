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
ITEM_TO_AMOUNT["item_ammo_357_large"] = 12
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
	ply:AllowFlashlight(true)
	
	player_manager.SetPlayerClass(ply, "player_coop")

	self.BaseClass:PlayerSpawn(ply)
end

function GM:InitPostEntity()
	for k,v in pairs(ents.FindByClass("weapon_*")) do
		if(v:CreatedByMap()) then
			local c = v:GetClass()
			local p = v:GetPos()
			local m = v:GetModel()
			local a = v:GetAngles()
			v:Remove()
			local e = ents.Create("ent_respawn")
			e:SetPos(p)
			e:SetAngles(a)
			e:SetModel(m)
			e.rclass = c
			e:Spawn()
		end
	end
	for k,v in pairs(ents.FindByClass("item_health*")) do
		if(v:CreatedByMap()) then
			local c = v:GetClass()
			local p = v:GetPos()
			local m = v:GetModel()
			local a = v:GetAngles()
			v:Remove()
			local e = ents.Create("ent_respawn")
			e:SetPos(p)
			e:SetAngles(a)
			e:SetModel(m)
			if(c == "item_healthkit") then
				e.health = 25
			else
				e.health = 10
			end
			e:Spawn()
		end
	end
	for k,v in pairs(ents.FindByClass("item_ammo_*")) do
		if(v:CreatedByMap() && v:GetClass() != "item_ammo_crate") then
			local c = v:GetClass()
			local p = v:GetPos()
			local m = v:GetModel()
			local a = v:GetAngles()
			v:Remove()
			local e = ents.Create("ent_respawn")
			e:SetPos(p)
			e:SetAngles(a)
			e:SetModel(m)
			e.aclass = c
			e.aamount = ITEM_TO_AMOUNT[c]
			e.arclass = ITEM_TO_AMMO[c]
			e:Spawn()
		end
	end
	for k,v in pairs(ents.FindByClass("item_box_buckshot")) do
		if(v:CreatedByMap()) then
			local c = v:GetClass()
			local p = v:GetPos()
			local m = v:GetModel()
			local a = v:GetAngles()
			v:Remove()
			local e = ents.Create("ent_respawn")
			e:SetPos(p)
			e:SetAngles(a)
			e:SetModel(m)
			e.aclass = c
			e.aamount = ITEM_TO_AMOUNT[c]
			e.arclass = ITEM_TO_AMMO[c]
			e:Spawn()
		end
	end
	for k,v in pairs(ents.FindByClass("item_rpg_round")) do
		if(v:CreatedByMap()) then
			local c = v:GetClass()
			local p = v:GetPos()
			local m = v:GetModel()
			local a = v:GetAngles()
			v:Remove()
			local e = ents.Create("ent_respawn")
			e:SetPos(p)
			e:SetAngles(a)
			e:SetModel(m)
			e.aclass = c
			e.aamount = ITEM_TO_AMOUNT[c]
			e.arclass = ITEM_TO_AMMO[c]
			e:Spawn()
		end
	end
end

function GM:PlayerCanPickupItem(ply, item)
	-- Limit max ammo
	local itemClass = item:GetClass()
	
	return self:PlayerAllowedItem(ply,itemClass)
end

function GM:PlayerAllowedItem(ply,itemClass)
	if ITEM_TO_AMMO[itemClass] ~= nil then -- Item exists in conversion table
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
	
	return true
end

function GM:PlayerCanPickupWeapon(ply, wep)
	local wepClass = wep:GetClass()
	
	return self:PlayerAllowedWeapon(ply,wepClass)
end

function GM:PlayerAllowedWeapon(ply,wepClass)
	if !ply:HasWeapon(wepClass) then
		return true
	end
	
	if WEP_TO_AMMO[wepClass] ~= nil then -- Weapon exists in conversion table
		local ammo = WEP_TO_AMMO[wepClass]
		local maxAmmo = MAX_AMMO[ammo]
		local clipSize = WEP_CLIP_SIZE[wepClass]
		local currentAmmo = ply:GetAmmoCount(ammo)
		if currentAmmo >= maxAmmo then
			return false
		elseif currentAmmo + clipSize > maxAmmo then
			ply:SetAmmo(maxAmmo - clipSize, ammo)
		end
	end

	return true
end

function GM:CheckRespawnGive(ply,wepClass)
	if !ply:HasWeapon(wepClass) then
		return true
	end
	
	if WEP_TO_AMMO[wepClass] ~= nil then -- Weapon exists in conversion table
		local ammo = WEP_TO_AMMO[wepClass]
		local maxAmmo = MAX_AMMO[ammo]
		local currentAmmo = ply:GetAmmoCount(ammo)
		if currentAmmo >= maxAmmo then
			return false
		end
	end
	
	return true
end

function GM:GiveWep(ply,class) --for ent respawner
	ply:Give(class)
	if(ply:HasWeapon(class) && WEP_TO_AMMO[class]) then
		ply:GiveAmmo(WEP_CLIP_SIZE[class],WEP_TO_AMMO[class])
	end
end