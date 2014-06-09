AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("rtv/config.lua")
AddCSLuaFile("rtv/cl_rtv.lua")

include("sv_mapseries.lua")
include("shared.lua")
include("rtv/sv_rtv.lua")

resource.AddFile("models/items/ammocrate_buckshot.mdl")
resource.AddFile("models/items/ammocrate_pistol.mdl")
resource.AddFile("models/hunter.mdl")
resource.AddFile("models/hunter_animations.mdl")
resource.AddFile("models/weapons/hunter_flechette.mdl")
resource.AddFile("models/zombie/zombie_soldier.mdl")
resource.AddFile("models/zombie/zombie_soldier_animations.mdl")
resource.AddFile("models/zombie/zombie_soldier_legs.mdl")
resource.AddFile("models/zombie/zombie_soldier_torso.mdl")

resource.AddFile("materials/models/items/ammocrate_buckshot.vmt")
resource.AddFile("materials/models/items/ammocrate_pistol.vmt")
resource.AddFile("materials/models/weapons/hunter_flechette.vmt")
resource.AddFile("materials/models/zombie_classic/combinesoldiersheet_zombie.vmt")
resource.AddFile("materials/models/zombie_classic/combinesoldiersheet_zombie_normal.vtf")
resource.AddFile("materials/models/zombie_classic/combinesoldiersheet_zombie_phong.vtf")

local function AddDir(dir)
	for k,v in pairs(file.Find(dir.."/*", "GAME")) do
		resource.AddSingleFile(dir.."/"..v)
	end
end

AddDir("sound/npc/ministrider")
AddDir("sound/npc/zombine")
AddDir("materials/models/ministrider")

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

local REPLACE_ENTS = {}
REPLACE_ENTS["weapon_mp5k"] = "weapon_smg1"
REPLACE_ENTS["weapon_mg1"] = "weapon_ar2"
REPLACE_ENTS["weapon_sl8"] = "weapon_ar2"
REPLACE_ENTS["weapon_sniper"] = "weapon_crossbow"
REPLACE_ENTS["weapon_gauss"] = "weapon_smg1"
REPLACE_ENTS["weapon_medkit"] = "item_healthkit"
REPLACE_ENTS["npc_gargantua"] = "npc_antlionguard"
REPLACE_ENTS["npc_alien_grunt"] = "npc_combine_s"
REPLACE_ENTS["npc_hassassin"] = "npc_combine_s"
REPLACE_ENTS["npc_houndeye"] = "npc_headcrab"
REPLACE_ENTS["item_box_sl8_rounds"] = "item_ammo_ar2_large"
REPLACE_ENTS["item_box_sniper_rounds"] = "item_ammo_crossbow"

for k,_ in pairs(REPLACE_ENTS) do
	if(string.sub(k,1,4) != "npc_") then
		scripted_ents.Register({Type="point"}, k, false)
	end
end

scripted_ents.Register({Type="point"}, "info_player_equip", false)
scripted_ents.Register({Type="brush", Base="base_brush"}, "trigger_once_oc", false)
scripted_ents.Register({Type="brush", Base="base_brush"}, "trigger_multiple_oc", false)

local mapspawn = true

function GM:PlayerInitialSpawn(ply)
	local t = #player.GetAll()
	for k,v in pairs(ents.FindByClass("trigger_coop")) do
		if(v.percentage) then
			v:UpdatePlayerCount(t)
		end
	end
	
	self.BaseClass:PlayerInitialSpawn(ply)
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
		ne:SetKeyValue("spawnflags", v.spfl)
		if(v.oc_out) then
			for _,o in pairs(v.oc_out) do
				ne:Fire("AddOutput",o,0)
			end
		end
		ne:Spawn()
		v:Remove()
	end
	for k,v in pairs(ents.FindByClass("trigger_once_oc")) do
		local ne = ents.Create("trigger_once")
		ne:SetPos(v:GetPos())
		ne:SetAngles(v:GetAngles())
		ne:SetName(v:GetName())
		ne:SetModel(v:GetModel())
		ne:SetKeyValue("spawnflags", v.spfl)
		if(v.oc_out) then
			for _,o in pairs(v.oc_out) do
				ne:Fire("AddOutput",o,0)
			end
		end
		ne:Spawn()
		v:Remove()
	end
	for ent,replace in pairs(REPLACE_ENTS) do
		for k,v in pairs(ents.FindByClass(ent)) do
			if(v:CreatedByMap()) then
				v:SetSolid(SOLID_NONE)
			
				local ne = ents.Create(replace)
				ne:SetPos(v:GetPos())
				ne:SetAngles(v:GetAngles())
				ne:SetName(v:GetName())
				if(string.sub(ent,1,7) == "weapon_" || string.sub(ent,1,5) == "item_") then
					ne.oPos = v:GetPos()
					ne.oAng = v:GetAngles()
					ne.ei = v:EntIndex()
				end
				if(ent == "npc_hassassin") then
					ne:SetKeyValue( "additionalequipment", "weapon_smg1" )
				elseif(ent == "npc_alien_grunt") then
					ne:SetKeyValue( "additionalequipment", "weapon_ar2" )
				end
				ne:Spawn()
				if(v.out) then
					for _,o in pairs(v.out) do
						ne:Fire("AddOutput","OnDeath "..o,0)
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
	mapspawn = false
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

function GM:OnEntityCreated( ent )
	if(!mapspawn) then
		if(ent:GetClass() == "npc_gargantua") then
			timer.Simple(0.1,function()
				if(ent:IsValid()) then
					ent:SetNoDraw(true)
					ent:SetSolid(SOLID_NONE)
					local ne = ents.Create("npc_antlionguard")
					ne:SetPos(ent:GetPos())
					ne:SetAngles(ent:GetAngles())
					ne:SetName(ent:GetName())
					ne:Spawn()
					if(ent.out) then
						for k,v in pairs(ent.out) do
							ne:Fire("AddOutput","OnDeath "..v,0)
						end
					end
					ent:Remove()
				end
			end)
		elseif(ent:GetClass() == "npc_hassassin") then
			timer.Simple(0.1,function()
				if(ent:IsValid()) then
					ent:SetNoDraw(true)
					ent:SetSolid(SOLID_NONE)
					local ne = ents.Create("npc_combine_s")
					ne:SetPos(ent:GetPos())
					ne:SetAngles(ent:GetAngles())
					ne:SetName(ent:GetName())
					ne:SetKeyValue( "additionalequipment", "weapon_smg1" )
					ne:Spawn()
					if(ent.out) then
						for k,v in pairs(ent.out) do
							ne:Fire("AddOutput","OnDeath "..v,0)
						end
					end
					ent:Remove()
				end
			end)
		elseif(ent:GetClass() == "npc_alien_grunt") then
			timer.Simple(0.1,function()
				if(ent:IsValid()) then
					ent:SetNoDraw(true)
					ent:SetSolid(SOLID_NONE)
					local ne = ents.Create("npc_combine_s")
					ne:SetPos(ent:GetPos())
					ne:SetAngles(ent:GetAngles())
					ne:SetName(ent:GetName())
					ne:SetKeyValue( "additionalequipment", "weapon_ar2" )
					ne:Spawn()
					if(ent.out) then
						for k,v in pairs(ent.out) do
							ne:Fire("AddOutput","OnDeath "..v,0)
						end
					end
					ent:Remove()
				end
			end)
		elseif(ent:GetClass() == "npc_houndeye") then
			timer.Simple(0.1,function()
				if(ent:IsValid()) then
					ent:SetNoDraw(true)
					ent:SetSolid(SOLID_NONE)
					local ne = ents.Create("npc_headcrab")
					ne:SetPos(ent:GetPos())
					ne:SetAngles(ent:GetAngles())
					ne:SetName(ent:GetName())
					ne:Spawn()
					if(ent.out) then
						for k,v in pairs(ent.out) do
							ne:Fire("AddOutput","OnDeath "..v,0)
						end
					end
					ent:Remove()
				end
			end)
		end
	end
end

local randselect = {
	"weapon_shotgun",
	"weapon_ar2",
	"weapon_smg1",
	"weapon_pistol"
}

function GM:EntityKeyValue(e,k,v)
	if(k == "OnDeath") then
		if(e:GetClass() == "npc_gargantua" || e:GetClass() == "npc_aliengrunt" || e:GetClass() == "npc_hassassin" || e:GetClass() == "npc_houndeye") then
			if(!e.out) then e.out = {} end
			table.insert(e.out,v)
		end
	end
	if(e:GetClass() == "trigger_multiple_oc" || e:GetClass() == "trigger_once_oc") then
		if(string.sub(k,1,2) == "On") then
			if(!e.oc_out) then e.oc_out = {} end
			table.insert(e.oc_out,k.." "..v)
		elseif(k == "spawnflags") then
			e.spf = v
		end
	end
	if(e:GetClass() == "info_player_coop" && k == "StartDisabled") then
		if(tonumber(v) == 1) then
			e.disabled = true
		end
	end
	if(k == "additionalequipment") then
		if(REPLACE_ENTS[v]) then
			return REPLACE_ENTS[v]
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
		self.SpawnPoints = ents.FindByClass( "info_player_deathmatch" )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )
		for k,v in pairs(ents.FindByClass( "info_player_coop" )) do
			if(!v.disabled) then
				table.insert(self.SpawnPoints,v)
			end
		end
		if(table.Count(self.SpawnPoints) == 0) then
			table.Add(self.SpawnPoints, ents.FindByClass("info_player_start"))
		end
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