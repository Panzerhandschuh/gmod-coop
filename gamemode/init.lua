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
include("crowbar_dmg_fix.lua")

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
local WEAPON_RESPAWN_TIME = 3

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

local CLASS_CONFIG = {}

CLASS_CONFIG["terrorist"] = {}
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "weapon_knife"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_pistol"] = "weapon_glock"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_357"] = "weapon_elite"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_smg1"] = "weapon_ak47"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_ar2"] = "weapon_g3sg1"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_shotgun"] = "weapon_m3"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_crossbow"] = "weapon_awp"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_frag"] = "weapon_hegrenade"
CLASS_CONFIG["terrorist"].REPLACEMENT_WEAPONS["weapon_slam"] = "weapon_m249"
CLASS_CONFIG["terrorist"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["terrorist"].MAX_AMMO = {}
CLASS_CONFIG["terrorist"].MAX_AMMO["pistol"] = 120 -- glock
CLASS_CONFIG["terrorist"].MAX_AMMO["357"] = 120 -- elite
CLASS_CONFIG["terrorist"].MAX_AMMO["smg1"] = 120 -- ak47
CLASS_CONFIG["terrorist"].MAX_AMMO["ar2"] = 60 -- g3sg1
CLASS_CONFIG["terrorist"].MAX_AMMO["buckshot"] = 32 -- m3
CLASS_CONFIG["terrorist"].MAX_AMMO["xbowbolt"] = 30 -- awp
CLASS_CONFIG["terrorist"].MAX_AMMO["grenade"] = 1 -- he grenade
CLASS_CONFIG["terrorist"].MAX_AMMO["slam"] = 300 -- m249
CLASS_CONFIG["terrorist"].PICKUP_AMMO = {}
CLASS_CONFIG["terrorist"].PICKUP_AMMO["pistol"] = 20 -- glock
CLASS_CONFIG["terrorist"].PICKUP_AMMO["357"] = 30 -- elite
CLASS_CONFIG["terrorist"].PICKUP_AMMO["smg1"] = 30 -- ak47
CLASS_CONFIG["terrorist"].PICKUP_AMMO["ar2"] = 20 -- g3sg1
CLASS_CONFIG["terrorist"].PICKUP_AMMO["buckshot"] = 8 -- m3
CLASS_CONFIG["terrorist"].PICKUP_AMMO["xbowbolt"] = 5 -- awp
CLASS_CONFIG["terrorist"].PICKUP_AMMO["grenade"] = 1 -- he grenade
CLASS_CONFIG["terrorist"].PICKUP_AMMO["slam"] = 50 -- m249

CLASS_CONFIG["counterterrorist"] = {}
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "weapon_knife"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_pistol"] = "weapon_usp"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_357"] = "weapon_deagle"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_smg1"] = "weapon_m4a1"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_ar2"] = "weapon_sg550"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_shotgun"] = "weapon_xm1014"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_crossbow"] = "weapon_scout"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_frag"] = "weapon_hegrenade"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_WEAPONS["weapon_slam"] = "weapon_m249"
CLASS_CONFIG["counterterrorist"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["counterterrorist"].MAX_AMMO = {}
CLASS_CONFIG["counterterrorist"].MAX_AMMO["pistol"] = 120 -- usp
CLASS_CONFIG["counterterrorist"].MAX_AMMO["357"] = 120 -- deagle
CLASS_CONFIG["counterterrorist"].MAX_AMMO["smg1"] = 120 -- m4a1
CLASS_CONFIG["counterterrorist"].MAX_AMMO["ar2"] = 60 -- sg550
CLASS_CONFIG["counterterrorist"].MAX_AMMO["buckshot"] = 32 -- xm1014
CLASS_CONFIG["counterterrorist"].MAX_AMMO["xbowbolt"] = 30 -- scout
CLASS_CONFIG["counterterrorist"].MAX_AMMO["grenade"] = 1 -- he grenade
CLASS_CONFIG["counterterrorist"].MAX_AMMO["slam"] = 300 -- m249
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO = {}
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["pistol"] = 12 -- usp
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["357"] = 7 -- deagle
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["smg1"] = 30 -- m4a1
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["ar2"] = 30 -- sg550
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["buckshot"] = 7 -- xm1014
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["xbowbolt"] = 5 -- scout
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["grenade"] = 1 -- he grenade
CLASS_CONFIG["counterterrorist"].PICKUP_AMMO["slam"] = 50 -- m249

CLASS_CONFIG["scout"] = {}
CLASS_CONFIG["scout"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["scout"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_bat"
CLASS_CONFIG["scout"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_pistol_scout"
CLASS_CONFIG["scout"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_pistol_scout"
CLASS_CONFIG["scout"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_scattergun"
CLASS_CONFIG["scout"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_scattergun"
CLASS_CONFIG["scout"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["scout"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["scout"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["scout"].MAX_AMMO = {}
CLASS_CONFIG["scout"].MAX_AMMO["pistol"] = 100 -- pistol
CLASS_CONFIG["scout"].MAX_AMMO["smg1"] = 64 -- scattergun
CLASS_CONFIG["scout"].PICKUP_AMMO = {}
CLASS_CONFIG["scout"].PICKUP_AMMO["pistol"] = 12 -- pistol
CLASS_CONFIG["scout"].PICKUP_AMMO["smg1"] = 6 -- scattergun

CLASS_CONFIG["soldier"] = {}
CLASS_CONFIG["soldier"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["soldier"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_shovel"
CLASS_CONFIG["soldier"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_shotgun_soldier"
CLASS_CONFIG["soldier"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_shotgun_soldier"
CLASS_CONFIG["soldier"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_rocketlauncher"
CLASS_CONFIG["soldier"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_rocketlauncher"
CLASS_CONFIG["soldier"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["soldier"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["soldier"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["soldier"].MAX_AMMO = {}
CLASS_CONFIG["soldier"].MAX_AMMO["pistol"] = 32 -- shotgun
CLASS_CONFIG["soldier"].MAX_AMMO["smg1"] = 24 -- rocket launcher
CLASS_CONFIG["soldier"].PICKUP_AMMO = {}
CLASS_CONFIG["soldier"].PICKUP_AMMO["pistol"] = 6 -- shotgun
CLASS_CONFIG["soldier"].PICKUP_AMMO["smg1"] = 4 -- rocket launcher

CLASS_CONFIG["pyro"] = {}
CLASS_CONFIG["pyro"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["pyro"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_fireaxe"
CLASS_CONFIG["pyro"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_shotgun_pyro"
CLASS_CONFIG["pyro"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_shotgun_pyro"
CLASS_CONFIG["pyro"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_flamethrower"
CLASS_CONFIG["pyro"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_flamethrower"
CLASS_CONFIG["pyro"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["pyro"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["pyro"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["pyro"].MAX_AMMO = {}
CLASS_CONFIG["pyro"].MAX_AMMO["pistol"] = 32 -- shotgun
CLASS_CONFIG["pyro"].MAX_AMMO["smg1"] = 200 -- flamethrower
CLASS_CONFIG["pyro"].PICKUP_AMMO = {}
CLASS_CONFIG["pyro"].PICKUP_AMMO["pistol"] = 6 -- shotgun
CLASS_CONFIG["pyro"].PICKUP_AMMO["smg1"] = 50 -- flamethrower

CLASS_CONFIG["demoman"] = {}
CLASS_CONFIG["demoman"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["demoman"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_bottle"
CLASS_CONFIG["demoman"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_grenadelauncher"
CLASS_CONFIG["demoman"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_grenadelauncher"
CLASS_CONFIG["demoman"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_pipebomblauncher"
CLASS_CONFIG["demoman"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_pipebomblauncher"
CLASS_CONFIG["demoman"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["demoman"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["demoman"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["demoman"].MAX_AMMO = {}
CLASS_CONFIG["demoman"].MAX_AMMO["pistol"] = 32 -- sticky launcher
CLASS_CONFIG["demoman"].MAX_AMMO["smg1"] = 20 -- pipe launcher
CLASS_CONFIG["demoman"].PICKUP_AMMO = {}
CLASS_CONFIG["demoman"].PICKUP_AMMO["pistol"] = 4 -- sticky launcher
CLASS_CONFIG["demoman"].PICKUP_AMMO["smg1"] = 4 -- pipe launcher

CLASS_CONFIG["heavy"] = {}
CLASS_CONFIG["heavy"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["heavy"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_fists"
CLASS_CONFIG["heavy"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_shotgun_hwg"
CLASS_CONFIG["heavy"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_shotgun_hwg"
CLASS_CONFIG["heavy"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_minigun"
CLASS_CONFIG["heavy"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_minigun"
CLASS_CONFIG["heavy"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["heavy"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["heavy"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["heavy"].MAX_AMMO = {}
CLASS_CONFIG["heavy"].MAX_AMMO["pistol"] = 32 -- shotgun
CLASS_CONFIG["heavy"].MAX_AMMO["smg1"] = 200 -- minigun
CLASS_CONFIG["heavy"].PICKUP_AMMO = {}
CLASS_CONFIG["heavy"].PICKUP_AMMO["pistol"] = 6 -- shotgun
CLASS_CONFIG["heavy"].PICKUP_AMMO["smg1"] = 50 -- minigun

CLASS_CONFIG["engineer"] = {}
CLASS_CONFIG["engineer"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["engineer"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_wrench"
CLASS_CONFIG["engineer"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_pistol"
CLASS_CONFIG["engineer"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_pistol"
CLASS_CONFIG["engineer"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_shotgun_primary"
CLASS_CONFIG["engineer"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_shotgun_primary"
CLASS_CONFIG["engineer"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["engineer"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["engineer"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["engineer"].MAX_AMMO = {}
CLASS_CONFIG["engineer"].MAX_AMMO["pistol"] = 200 -- pistol
CLASS_CONFIG["engineer"].MAX_AMMO["smg1"] = 128 -- shotgun
CLASS_CONFIG["engineer"].PICKUP_AMMO = {}
CLASS_CONFIG["engineer"].PICKUP_AMMO["pistol"] = 24 -- pistol
CLASS_CONFIG["engineer"].PICKUP_AMMO["smg1"] = 12 -- shotgun

CLASS_CONFIG["medic"] = {}
CLASS_CONFIG["medic"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["medic"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_bonesaw"
CLASS_CONFIG["medic"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_medigun"
CLASS_CONFIG["medic"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_medigun"
CLASS_CONFIG["medic"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_syringegun_medic"
CLASS_CONFIG["medic"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_syringegun_medic"
CLASS_CONFIG["medic"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["medic"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["medic"].MAX_AMMO = {}
CLASS_CONFIG["medic"].MAX_AMMO["smg1"] = 150 -- syringe gun
CLASS_CONFIG["medic"].PICKUP_AMMO = {}
CLASS_CONFIG["medic"].PICKUP_AMMO["smg1"] = 40 -- syringe gun

CLASS_CONFIG["sniper"] = {}
CLASS_CONFIG["sniper"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["sniper"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_club"
CLASS_CONFIG["sniper"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_smg"
CLASS_CONFIG["sniper"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_smg"
CLASS_CONFIG["sniper"].REPLACEMENT_WEAPONS["weapon_smg1"] = "tf_weapon_sniperrifle"
CLASS_CONFIG["sniper"].REPLACEMENT_WEAPONS["weapon_ar2"] = "tf_weapon_sniperrifle"
CLASS_CONFIG["sniper"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["sniper"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["sniper"].REPLACEMENT_AMMO["ar2"] = "smg1"
CLASS_CONFIG["sniper"].MAX_AMMO = {}
CLASS_CONFIG["sniper"].MAX_AMMO["pistol"] = 150 -- smg
CLASS_CONFIG["sniper"].MAX_AMMO["smg1"] = 50 -- sniper rifle
CLASS_CONFIG["sniper"].PICKUP_AMMO = {}
CLASS_CONFIG["sniper"].PICKUP_AMMO["pistol"] = 25 -- smg
CLASS_CONFIG["sniper"].PICKUP_AMMO["smg1"] = 5 -- sniper rifle

CLASS_CONFIG["spy"] = {}
CLASS_CONFIG["spy"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["spy"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "tf_weapon_knife"
CLASS_CONFIG["spy"].REPLACEMENT_WEAPONS["weapon_pistol"] = "tf_weapon_revolver"
CLASS_CONFIG["spy"].REPLACEMENT_WEAPONS["weapon_357"] = "tf_weapon_revolver"
CLASS_CONFIG["spy"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["spy"].REPLACEMENT_AMMO["357"] = "pistol"
CLASS_CONFIG["spy"].MAX_AMMO = {}
CLASS_CONFIG["spy"].MAX_AMMO["pistol"] = 36 -- revolver
CLASS_CONFIG["spy"].PICKUP_AMMO = {}
CLASS_CONFIG["spy"].PICKUP_AMMO["pistol"] = 6 -- revolver

CLASS_CONFIG["hl1_gordon"] = {}
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "weapon_hl1_crowbar"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_pistol"] = "weapon_hl1_glock"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_357"] = "weapon_hl1_357"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_smg1"] = "weapon_hl1_mp5"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_ar2"] = "weapon_hl1_gauss"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_shotgun"] = "weapon_hl1_shotgun"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_crossbow"] = "weapon_hl1_crossbow"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_rpg"] = "weapon_hl1_rpg"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_frag"] = "weapon_hl1_handgrenade"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_WEAPONS["weapon_slam"] = "weapon_hl1_tripmine"
CLASS_CONFIG["hl1_gordon"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["hl1_gordon"].MAX_AMMO = {}
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["pistol"] = 250 -- glock
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["357"] = 36 -- 357
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["smg1"] = 250 -- mp5
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["smg1_grenade"] = 5 -- mp5
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["ar2"] = 100 -- gauss
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["buckshot"] = 125 -- shotgun
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["xbowbolt"] = 50 -- crossbow
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["rpg_round"] = 5 -- rpg
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["grenade"] = 10 -- hand grenade
CLASS_CONFIG["hl1_gordon"].MAX_AMMO["slam"] = 5 -- tripmine
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO = {}
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["pistol"] = 36 -- glock
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["357"] = 6 -- 357
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["smg1"] = 50 -- mp5
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["smg1_grenade"] = 1 -- mp5
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["ar2"] = 25 -- gauss
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["buckshot"] = 16 -- shotgun
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["xbowbolt"] = 5 -- crossbow
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["rpg_round"] = 1 -- rpg
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["grenade"] = 1 -- hand grenade
CLASS_CONFIG["hl1_gordon"].PICKUP_AMMO["slam"] = 1 -- tripmine

CLASS_CONFIG["hl1_scientist"] = {}
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "weapon_hl1_crowbar"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_pistol"] = "weapon_hl1_glock"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_357"] = "weapon_hl1_357"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_smg1"] = "weapon_hl1_mp5"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_ar2"] = "weapon_hl1_egon"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_shotgun"] = "weapon_hl1_shotgun"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_crossbow"] = "weapon_hl1_crossbow"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_rpg"] = "weapon_hl1_rpg"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_frag"] = "weapon_hl1_snark"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_WEAPONS["weapon_slam"] = "weapon_hl1_tripmine"
CLASS_CONFIG["hl1_scientist"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["hl1_scientist"].MAX_AMMO = {}
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["pistol"] = 250 -- glock
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["357"] = 36 -- 357
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["smg1"] = 250 -- mp5
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["smg1_grenade"] = 5 -- mp5
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["ar2"] = 100 -- egon
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["buckshot"] = 125 -- shotgun
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["xbowbolt"] = 50 -- crossbow
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["rpg_round"] = 5 -- rpg
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["grenade"] = 5 -- snark
CLASS_CONFIG["hl1_scientist"].MAX_AMMO["slam"] = 5 -- tripmine
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO = {}
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["pistol"] = 36 -- glock
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["357"] = 6 -- 357
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["smg1"] = 50 -- mp5
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["smg1_grenade"] = 1 -- mp5
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["ar2"] = 25 -- egon
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["buckshot"] = 16 -- shotgun
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["xbowbolt"] = 5 -- crossbow
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["rpg_round"] = 1 -- rpg
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["grenade"] = 1 -- snark
CLASS_CONFIG["hl1_scientist"].PICKUP_AMMO["slam"] = 1 -- tripmine

CLASS_CONFIG["hl1_barney"] = {}
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "weapon_hl1_crowbar"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_pistol"] = "weapon_hl1_glock"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_357"] = "weapon_hl1_357"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_smg1"] = "weapon_hl1_mp5"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_ar2"] = "weapon_hl1_hornetgun"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_shotgun"] = "weapon_hl1_shotgun"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_crossbow"] = "weapon_hl1_crossbow"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_rpg"] = "weapon_hl1_rpg"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_frag"] = "weapon_hl1_satchel"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_WEAPONS["weapon_slam"] = "weapon_hl1_tripmine"
CLASS_CONFIG["hl1_barney"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["hl1_barney"].MAX_AMMO = {}
CLASS_CONFIG["hl1_barney"].MAX_AMMO["pistol"] = 250 -- glock
CLASS_CONFIG["hl1_barney"].MAX_AMMO["357"] = 36 -- 357
CLASS_CONFIG["hl1_barney"].MAX_AMMO["smg1"] = 250 -- mp5
CLASS_CONFIG["hl1_barney"].MAX_AMMO["smg1_grenade"] = 5 -- mp5
CLASS_CONFIG["hl1_barney"].MAX_AMMO["ar2"] = 16 -- hornet gun
CLASS_CONFIG["hl1_barney"].MAX_AMMO["buckshot"] = 125 -- shotgun
CLASS_CONFIG["hl1_barney"].MAX_AMMO["xbowbolt"] = 50 -- crossbow
CLASS_CONFIG["hl1_barney"].MAX_AMMO["rpg_round"] = 5 -- rpg
CLASS_CONFIG["hl1_barney"].MAX_AMMO["grenade"] = 5 -- satchel
CLASS_CONFIG["hl1_barney"].MAX_AMMO["slam"] = 5 -- tripmine
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO = {}
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["pistol"] = 36 -- glock
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["357"] = 6 -- 357
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["smg1"] = 50 -- mp5
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["smg1_grenade"] = 1 -- mp5
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["ar2"] = 4 -- hornet gun
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["buckshot"] = 16 -- shotgun
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["xbowbolt"] = 5 -- crossbow
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["rpg_round"] = 1 -- rpg
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["grenade"] = 1 -- satchel
CLASS_CONFIG["hl1_barney"].PICKUP_AMMO["slam"] = 1 -- tripmine

CLASS_CONFIG["quake3"] = {}
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS = {}
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_crowbar"] = "weapon_q3_gauntlet"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_pistol"] = "weapon_q3_machinegun"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_357"] = "weapon_q3_shotgun"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_smg1"] = "weapon_q3_rocketlauncher"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_ar2"] = "weapon_q3_grenadelauncher"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_shotgun"] = "weapon_q3_plasmagun"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_crossbow"] = "weapon_q3_lightninggun"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_frag"] = "weapon_q3_railgun"
CLASS_CONFIG["quake3"].REPLACEMENT_WEAPONS["weapon_slam"] = "weapon_q3_bfg10k"
CLASS_CONFIG["quake3"].REPLACEMENT_AMMO = {}
CLASS_CONFIG["quake3"].MAX_AMMO = {}
CLASS_CONFIG["quake3"].MAX_AMMO["pistol"] = 200 -- machine gun
CLASS_CONFIG["quake3"].MAX_AMMO["357"] = 25 -- shotgun
CLASS_CONFIG["quake3"].MAX_AMMO["smg1"] = 25 -- rocket launcher
CLASS_CONFIG["quake3"].MAX_AMMO["ar2"] = 25 -- grenade launcher
CLASS_CONFIG["quake3"].MAX_AMMO["buckshot"] = 200 -- plasma gun
CLASS_CONFIG["quake3"].MAX_AMMO["xbowbolt"] = 200 -- lightning gun
CLASS_CONFIG["quake3"].MAX_AMMO["grenade"] = 25 -- rail gun
CLASS_CONFIG["quake3"].MAX_AMMO["slam"] = 25 -- bfg
CLASS_CONFIG["quake3"].PICKUP_AMMO = {}
CLASS_CONFIG["quake3"].PICKUP_AMMO["pistol"] = 25 -- machine gun
CLASS_CONFIG["quake3"].PICKUP_AMMO["357"] = 5 -- shotgun
CLASS_CONFIG["quake3"].PICKUP_AMMO["smg1"] = 5 -- rocket launcher
CLASS_CONFIG["quake3"].PICKUP_AMMO["ar2"] = 5 -- grenade launcher
CLASS_CONFIG["quake3"].PICKUP_AMMO["buckshot"] = 25 -- plasma gun
CLASS_CONFIG["quake3"].PICKUP_AMMO["xbowbolt"] = 25 -- lightning gun
CLASS_CONFIG["quake3"].PICKUP_AMMO["grenade"] = 5 -- rail gun
CLASS_CONFIG["quake3"].PICKUP_AMMO["slam"] = 25 -- bfg

local IS_CUSTOM_WEAPON = {}

for k1,v1 in pairs(CLASS_CONFIG) do
	for k2,v2 in pairs(v1.REPLACEMENT_WEAPONS) do
		IS_CUSTOM_WEAPON[v2] = true
	end
end

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

WEP_TO_AMMO["weapon_ak47"] = "smg1"
WEP_TO_AMMO["weapon_ak47_admin"] = "smg1"
WEP_TO_AMMO["weapon_aug"] = "ar2"
WEP_TO_AMMO["weapon_awp"] = "xbowbolt"
WEP_TO_AMMO["weapon_c4"] = "slam"
WEP_TO_AMMO["weapon_deagle"] = "357"
WEP_TO_AMMO["weapon_elite"] = "357"
WEP_TO_AMMO["weapon_famas"] = "smg1"
WEP_TO_AMMO["weapon_fiveseven"] = "357"
WEP_TO_AMMO["weapon_flashbang"] = "grenade"
WEP_TO_AMMO["weapon_g3sg1"] = "ar2"
WEP_TO_AMMO["weapon_galil"] = "smg1"
WEP_TO_AMMO["weapon_glock"] = "pistol"
WEP_TO_AMMO["weapon_hegrenade"] = "grenade"
WEP_TO_AMMO["weapon_m3"] = "buckshot"
WEP_TO_AMMO["weapon_m4a1"] = "smg1"
WEP_TO_AMMO["weapon_m249"] = "ar2"
WEP_TO_AMMO["weapon_mac10"] = "smg1"
WEP_TO_AMMO["weapon_mp5navy"] = "smg1"
WEP_TO_AMMO["weapon_p90"] = "smg1"
WEP_TO_AMMO["weapon_p228"] = "pistol"
WEP_TO_AMMO["weapon_scout"] = "xbowbolt"
WEP_TO_AMMO["weapon_sg550"] = "ar2"
WEP_TO_AMMO["weapon_sg552"] = "ar2"
WEP_TO_AMMO["weapon_smokegrenade"] = "grenade"
WEP_TO_AMMO["weapon_tmp"] = "smg1"
WEP_TO_AMMO["weapon_ump45"] = "smg1"
WEP_TO_AMMO["weapon_usp"] = "pistol"
WEP_TO_AMMO["weapon_xm1014"] = "buckshot"
WEP_TO_AMMO["weapon_m249"] = "slam"

WEP_TO_AMMO["tf_weapon_flamethrower"] = "smg1"
WEP_TO_AMMO["tf_weapon_grenadelauncher"] = "pistol"
WEP_TO_AMMO["tf_weapon_minigun"] = "smg1"
WEP_TO_AMMO["tf_weapon_pipebomblauncher"] = "smg1"
WEP_TO_AMMO["tf_weapon_pistol"] = "pistol"
WEP_TO_AMMO["tf_weapon_pistol_scout"] = "pistol"
WEP_TO_AMMO["tf_weapon_revolver"] = "pistol"
WEP_TO_AMMO["tf_weapon_rocketlauncher"] = "smg1"
WEP_TO_AMMO["tf_weapon_scattergun"] = "smg1"
WEP_TO_AMMO["tf_weapon_shotgun_hwg"] = "pistol"
WEP_TO_AMMO["tf_weapon_shotgun_primary"] = "pistol"
WEP_TO_AMMO["tf_weapon_shotgun_pyro"] = "pistol"
WEP_TO_AMMO["tf_weapon_shotgun_soldier"] = "pistol"
WEP_TO_AMMO["tf_weapon_smg"] = "pistol"
WEP_TO_AMMO["tf_weapon_sniperrifle"] = "smg1"
WEP_TO_AMMO["tf_weapon_syringegun_medic"] = "smg1"

WEP_TO_AMMO["weapon_hl1_glock"] = "pistol"
WEP_TO_AMMO["weapon_hl1_357"] = "357"
WEP_TO_AMMO["weapon_hl1_mp5"] = "smg1"
WEP_TO_AMMO["weapon_hl1_egon"] = "ar2"
WEP_TO_AMMO["weapon_hl1_gauss"] = "ar2"
WEP_TO_AMMO["weapon_hl1_hornetgun"] = "ar2"
WEP_TO_AMMO["weapon_hl1_shotgun"] = "buckshot"
WEP_TO_AMMO["weapon_hl1_crossbow"] = "xbowbolt"
WEP_TO_AMMO["weapon_hl1_rpg"] = "rpg_round"
WEP_TO_AMMO["weapon_hl1_handgrenade"] = "grenade"
WEP_TO_AMMO["weapon_hl1_satchel"] = "grenade"
WEP_TO_AMMO["weapon_hl1_snark"] = "grenade"
WEP_TO_AMMO["weapon_hl1_tripmine"] = "slam"

WEP_TO_AMMO["weapon_q3_machinegun"] = "pistol"
WEP_TO_AMMO["weapon_q3_chaingun"] = "pistol"
WEP_TO_AMMO["weapon_q3_shotgun"] = "357"
WEP_TO_AMMO["weapon_q3_rocketlauncher"] = "smg1"
WEP_TO_AMMO["weapon_q3_grenadelauncher"] = "ar2"
WEP_TO_AMMO["weapon_q3_plasmagun"] = "buckshot"
WEP_TO_AMMO["weapon_q3_lightninggun"] = "xbowbolt"
WEP_TO_AMMO["weapon_q3_railgun"] = "grenade"
WEP_TO_AMMO["weapon_q3_bfg10k"] = "slam"

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

local PATROL_BLACKLIST = {}
PATROL_BLACKLIST["npc_headcrab"] = true
PATROL_BLACKLIST["npc_headcrab_fast"] = true
PATROL_BLACKLIST["npc_headcrab_poison"] = true
PATROL_BLACKLIST["npc_headcrab_black"] = true
PATROL_BLACKLIST["npc_manhack"] = true
PATROL_BLACKLIST["npc_barnacle"] = true
PATROL_BLACKLIST["npc_helicopter"] = true
PATROL_BLACKLIST["npc_gunship"] = true

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

CreateConVar('coop_npc_dmg_scale', 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE} )
CreateConVar('coop_plr_dmg_scale', 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE} )

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

	UpdateDifficulty()
end

function UpdateDifficulty()
	timer.Simple(1, function()
		local t = #player.GetAll()
		local plrDmgScale = GetConVar("coop_plr_dmg_scale")
		local npcDmgScale = GetConVar("coop_npc_dmg_scale")
		if (t == 1) then
			plrDmgScale:SetFloat(1)
			npcDmgScale:SetFloat(1)
		elseif (t == 2) then
			plrDmgScale:SetFloat(0.85)
			npcDmgScale:SetFloat(1.05)
		elseif (t == 3) then
			plrDmgScale:SetFloat(0.72)
			npcDmgScale:SetFloat(1.1)
		elseif (t == 4) then
			plrDmgScale:SetFloat(0.61)
			npcDmgScale:SetFloat(1.15)
		elseif (t == 5) then
			plrDmgScale:SetFloat(0.52)
			npcDmgScale:SetFloat(1.2)
		elseif (t == 6) then
			plrDmgScale:SetFloat(0.44)
			npcDmgScale:SetFloat(1.25)
		elseif (t == 7) then
			plrDmgScale:SetFloat(0.38)
			npcDmgScale:SetFloat(1.3)
		elseif (t == 8) then
			plrDmgScale:SetFloat(0.32)
			npcDmgScale:SetFloat(1.35)
		elseif (t == 9) then
			plrDmgScale:SetFloat(0.27)
			npcDmgScale:SetFloat(1.4)
		elseif (t == 10) then
			plrDmgScale:SetFloat(0.23)
			npcDmgScale:SetFloat(1.45)
		elseif (t == 11) then
			plrDmgScale:SetFloat(0.2)
			npcDmgScale:SetFloat(1.5)
		elseif (t == 12) then
			plrDmgScale:SetFloat(0.17)
			npcDmgScale:SetFloat(1.55)
		end
	end)
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

	UpdateDifficulty()
	
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

function GM:EntityTakeDamage(target, dmginfo)
	if (target:IsPlayer()) then
		local inflictor = dmginfo:GetInflictor():GetClass()
		if (inflictor == "q3_rocket" || inflictor == "q3_grenade" || inflictor == "q3_bfg") then
			dmginfo:ScaleDamage(2)
		elseif (inflictor == "q3_plasma") then
			dmginfo:ScaleDamage(1.25)
		elseif (inflictor == "concussiveblast") then
			dmginfo:ScaleDamage(0.6)
		elseif (inflictor == "func_tank") then
			dmginfo:ScaleDamage(0.4)
		elseif (dmginfo:GetAttacker():IsNPC()) then
			local attackerClass = dmginfo:GetAttacker():GetClass()
			if (attackerClass == "npc_headcrab_black" || attackerClass == "npc_headcrab_poison") then
				return
			elseif (attackerClass == "npc_strider" && dmginfo:GetDamageType() == DMG_GENERIC) then
				dmginfo:ScaleDamage(0.6)
				return
			end
			
			local dmgScale = GetConVar('coop_npc_dmg_scale'):GetFloat()
			dmginfo:ScaleDamage(dmgScale)
		end
	elseif (target:IsNPC() && dmginfo:GetAttacker():IsPlayer()) then
		local targetClass = target:GetClass()
		if (targetClass == "npc_helicopter" || targetClass == "npc_gunship" || targetClass == "npc_strider") then
			return
		elseif ((targetClass == "npc_antlionguard" || targetClass == "npc_hunter") && dmginfo:IsExplosionDamage()) then
			dmginfo:SetDamageType(DMG_BULLET)
		end
		
		local dmgScale = GetConVar('coop_plr_dmg_scale'):GetFloat()
		dmginfo:ScaleDamage(dmgScale)
	end
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

	-- Improve npc aggression
	for _,npc in pairs(ents.FindByClass("npc_*")) do
		if (npc:IsNPC() && CheckCanPatrol(npc)) then
			npc:SetSchedule(SCHED_PATROL_WALK)
		end
	end
end

function CheckCanPatrol(npc)
	return (IsValid(npc) && npc:GetEnemy() == nil && npc:GetTarget() == nil && !npc:IsMoving() && npc:GetNPCState() == NPC_STATE_IDLE && !PATROL_BLACKLIST[npc:GetClass()])
end

function CheckMaxAmmo(ply, wep, ammoNum)
	if (ammoNum == -1) then
		return
	end

	local ammo = AMMONUM_TO_STRING[ammoNum]
	if (!ammo) then
		return
	end

	local maxAmmo = 999
	if (IS_CUSTOM_WEAPON[wep:GetClass()] && CLASS_CONFIG[ply._Class]) then
		maxAmmo = CLASS_CONFIG[ply._Class].MAX_AMMO[ammo]
	else
		maxAmmo = MAX_AMMO[ammo]
	end
	
	local currentAmmo = ply:GetAmmoCount(ammo)
	if (!currentAmmo || !maxAmmo) then
		return
	end

	if currentAmmo > maxAmmo then
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
	if (ITEM_TO_AMMO[itemClass]) then -- Item exists in conversion table
		local ammo = ITEM_TO_AMMO[itemClass]
		local replacementAmmo = GetReplacementAmmoType(ply, ammo)
		if (replacementAmmo) then
			local maxAmmo = GetMaxAmmo(ply, replacementAmmo)
			local currentAmmo = ply:GetAmmoCount(replacementAmmo)
			if currentAmmo >= maxAmmo then
				return false
			else
				local pickupAmmo = GetPickupAmmo(ply, replacementAmmo)
				ply:GiveAmmo(pickupAmmo, replacementAmmo)
				item:Remove()
				TryDuplicateItem(item, itemClass)

				return false
			end
		else
			local maxAmmo = GetMaxAmmo(ply, ammo)
			local currentAmmo = ply:GetAmmoCount(ammo)
			if currentAmmo >= maxAmmo then
				return false
			else
				TryDuplicateItem(item, itemClass)
				return true
			end
		end
	end

	TryDuplicateItem(item, itemClass)
    return true
end

function GetReplacementAmmoType(ply, ammo)
	if (ply._Class && CLASS_CONFIG[ply._Class] && CLASS_CONFIG[ply._Class].REPLACEMENT_AMMO[ammo]) then
		return CLASS_CONFIG[ply._Class].REPLACEMENT_AMMO[ammo]
	end

	return ammo
end

function GetPickupAmmo(ply, ammo)
	if (ply._Class && CLASS_CONFIG[ply._Class] && CLASS_CONFIG[ply._Class].PICKUP_AMMO[ammo]) then
		return CLASS_CONFIG[ply._Class].PICKUP_AMMO[ammo]
	end

	return 10
end

function GetMaxAmmo(ply, ammo)
	if (ply._Class && CLASS_CONFIG[ply._Class] && CLASS_CONFIG[ply._Class].MAX_AMMO[ammo]) then
		return CLASS_CONFIG[ply._Class].MAX_AMMO[ammo]
	end

	return MAX_AMMO[ammo]
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

	-- If this is a custom weapon, then pick it up immediately
	if (IS_CUSTOM_WEAPON[wep:GetClass()]) then
		return true
	end

	-- If the player is a custom class, look for a replacement weapon
	local wepClassOverride = nil
	if (CLASS_CONFIG[ply._Class]) then
		local repWep = CLASS_CONFIG[ply._Class].REPLACEMENT_WEAPONS[wepClass]
		if (repWep) then
			wepClassOverride = repWep
		end
	end

	if (wepClassOverride) then -- Equip player with custom weapon
		if wep:GetPrimaryAmmoType() == -1 || wepClassOverride == "tf_weapon_medigun" then -- Weapon type does not have ammo (crowbar, grav gun, etc)
			if (wepClassOverride) then
				if ply:HasWeapon(wepClassOverride) then -- Do not pickup the item if the player already has it
					return false
				else -- Player does not have this weapon, so equip it and duplicate if possible
					ply:Give(wepClassOverride)
					wep:Remove()
					TryDuplicateWeapon(wep, wepClass)
		
					return false -- Return false since player is manually being equipped
				end
			end
		end

		local ammo = WEP_TO_AMMO[wepClassOverride]
		local maxAmmo = CLASS_CONFIG[ply._Class].MAX_AMMO[ammo]
		local currentAmmo = ply:GetAmmoCount(ammo)

		-- Pickup new weapon
		if !ply:HasWeapon(wepClassOverride) then
			ply:Give(wepClassOverride)
			wep:Remove()
			TryDuplicateWeapon(wep, wepClass)

			return false
		end

		-- Check ammo capacity
		if currentAmmo >= maxAmmo then
			return false
		end

		local pickupAmmo = GetPickupAmmo(ply, ammo)
		ply:GiveAmmo(pickupAmmo, ammo)
		wep:Remove()
		TryDuplicateWeapon(wep, wepClass)

		return false
	else -- Equip player with HL2 weapon
		if wep:GetPrimaryAmmoType() == -1 then -- Weapon type does not have ammo (crowbar, grav gun, etc)
			if ply:HasWeapon(wepClass) then -- Do not pickup the item if the player already has it
				return false
			else -- Player does not have this weapon, so equip it and duplicate if possible
				TryDuplicateWeapon(wep, wepClass)
				return true
			end
		end

		local ammo = WEP_TO_AMMO[wepClass]
		local maxAmmo = MAX_AMMO[ammo]
		local currentAmmo = ply:GetAmmoCount(ammo)

		-- Pickup new weapon
		if !ply:HasWeapon(wepClass) then
			TryDuplicateWeapon(wep, wepClass)
			return true
		end
		
		-- Check ammo capacity
		if currentAmmo >= maxAmmo then
			return false
		end
		
		TryDuplicateWeapon(wep, wepClass)
		return true
	end
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
	if (string.sub(class,1,4) != "npc_" && string.sub(class,1,8) != "monster_") then
		return
	end

	if (REPLACE_ENTS[class]) then
		timer.Simple(0.1,function()
			if (ent:IsValid() && ent:IsNPC()) then
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
	else
		timer.Simple(0.1,function()
			if (ent:IsValid() && ent:IsNPC()) then
				if(ent.chealth) then
					ent:SetHealth(ent.chealth)
				end
			end
		end)
	end

	-- NPC Improvements
	timer.Simple(0.1,function()
		if (!ent:IsValid() || !ent:IsNPC()) then
			return
		end

		ent:SetLagCompensated(true)

		-- Improve NPC accuracy
		ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)

		-- Increase player detection range
		ent:Fire("SetMaxLookDistance", "99999")
		ent:Fire("WakeRadius", "99999")
		
		-- Immediately alert the NPC
		-- ent:SetNPCState(NPC_STATE_ALERT)
		-- ent:SetSchedule(SCHED_PATROL_WALK)

		-- Enable jumping
		--if (ent:SelectWeightedSequence(ACT_JUMP) != -1) then
		--	ent:CapabilitiesAdd(CAP_MOVE_JUMP)
		--end

		-- local players = player.GetAll()
		-- for k, v in pairs(players) do
		-- 	ent:AddEntityRelationship(v, D_HT)
		-- end

		if (class == "npc_stalker") then
			-- Increase aggression
			ent:SetSaveValue("m_iPlayerAggression", 1)
		end
	end)
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