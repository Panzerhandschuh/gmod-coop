
AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DuckSpeed			= 0.1		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.1		-- How fast to go from ducking, to not ducking
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 320
PLAYER.AvoidPlayers			= false

--
-- Set up the network table accessors
--
function PLAYER:SetupDataTables()

	BaseClass.SetupDataTables( self )

end


function PLAYER:Loadout()

	self.Player:RemoveAllAmmo()

	self.Player:StripWeapons()

	if (self.Player._Class == "terrorist") then
		self.Player:Give("weapon_knife")
		self.Player:Give("weapon_glock")
		self.Player:Give("weapon_ak47")
		self.Player:Give("weapon_hegrenade")
	elseif (self.Player._Class == "counterterrorist") then
		self.Player:Give("weapon_knife")
		self.Player:Give("weapon_usp")
		self.Player:Give("weapon_m4a1")
		self.Player:Give("weapon_hegrenade")
	elseif (self.Player._Class == "scout") then
		self.Player:Give("tf_weapon_bat")
		self.Player:Give("tf_weapon_pistol_scout")
		self.Player:Give("tf_weapon_scattergun")
	elseif (self.Player._Class == "soldier") then
		self.Player:Give("tf_weapon_shovel")
		self.Player:Give("tf_weapon_shotgun_soldier")
		self.Player:Give("tf_weapon_rocketlauncher")
	elseif (self.Player._Class == "pyro") then
		self.Player:Give("tf_weapon_fireaxe")
		self.Player:Give("tf_weapon_shotgun_pyro")
		self.Player:Give("tf_weapon_flamethrower")
	elseif (self.Player._Class == "demoman") then
		self.Player:Give("tf_weapon_bottle")
		self.Player:Give("tf_weapon_pipebomblauncher")
		self.Player:Give("tf_weapon_grenadelauncher")
	elseif (self.Player._Class == "heavy") then
		self.Player:Give("tf_weapon_fists")
		self.Player:Give("tf_weapon_shotgun_hwg")
		self.Player:Give("tf_weapon_minigun")
	elseif (self.Player._Class == "engineer") then
		self.Player:Give("tf_weapon_wrench")
		self.Player:Give("tf_weapon_pistol")
		self.Player:Give("tf_weapon_shotgun_primary")
	elseif (self.Player._Class == "medic") then
		self.Player:Give("tf_weapon_bonesaw")
		self.Player:Give("tf_weapon_syringegun_medic")
		self.Player:Give("tf_weapon_medigun")
	elseif (self.Player._Class == "sniper") then
		self.Player:Give("tf_weapon_club")
		self.Player:Give("tf_weapon_smg")
		self.Player:Give("tf_weapon_sniperrifle")
	elseif (self.Player._Class == "spy") then
		self.Player:Give("tf_weapon_knife")
		self.Player:Give("tf_weapon_revolver")
	else
		self.Player:Give("weapon_crowbar")
		self.Player:Give("weapon_pistol")
		self.Player:Give("weapon_smg1")
		self.Player:Give("weapon_frag")

		self.Player:GiveAmmo(150, "Pistol", true)
		self.Player:GiveAmmo(45, "SMG1", true)
		self.Player:GiveAmmo(1, "grenade", true)
	end
	
	self.Player:Give("weapon_physcannon")

	self.Player:SwitchToDefaultWeapon()

end

function PLAYER:SetModel()
	--self.Player:SetModel("models/player/group01/male_01.mdl") --temp
	BaseClass.SetModel( self )
	
	local skin = self.Player:GetInfoNum( "cl_playerskin", 0 )
	self.Player:SetSkin( skin )

	local groups = self.Player:GetInfo( "cl_playerbodygroups" )
	if ( groups == nil ) then groups = "" end
	local groups = string.Explode( " ", groups )
	for k = 0, self.Player:GetNumBodyGroups() - 1 do
		self.Player:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
	end
end

--
-- Called when the player spawns
--
function PLAYER:Spawn()

	BaseClass.Spawn(self)
	
	self.Player:SetCrouchedWalkSpeed(0.32)
	-- self.Player:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 36))
end

--
-- Return true to draw local (thirdperson) camera - false to prevent - nothing to use default behaviour
--
function PLAYER:ShouldDrawLocal() 

end

--
-- Allow player class to create move
--
function PLAYER:CreateMove( cmd )

end

--
-- Allow changing the player's view
--
function PLAYER:CalcView( view )

end

function PLAYER:GetHandsModel()

	--return { model = "models/weapons/c_arms_citizen.mdl", skin = 1, body = "0000000" }
	local cl_playermodel = self.Player:GetInfo( "cl_playermodel" )
	return player_manager.TranslatePlayerHands( cl_playermodel )

end

function PLAYER:StartMove( move )

end

function PLAYER:FinishMove( move )

end

player_manager.RegisterClass( "player_coop", PLAYER, "player_default" )
