
AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DuckSpeed			= 0.1		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.1		-- How fast to go from ducking, to not ducking
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 320

--
-- Set up the network table accessors
--
function PLAYER:SetupDataTables()

	BaseClass.SetupDataTables( self )

end


function PLAYER:Loadout()

	self.Player:RemoveAllAmmo()

	-- Start ammo
	self.Player:GiveAmmo(150, "Pistol", true)
	self.Player:GiveAmmo(45, "SMG1", true)
	self.Player:GiveAmmo(1, "grenade", true)
	
	-- Start weapons
	self.Player:Give("weapon_crowbar")
	self.Player:Give("weapon_physcannon")
	self.Player:Give("weapon_pistol")
	self.Player:Give("weapon_smg1")
	self.Player:Give("weapon_frag")

	self.Player:SwitchToDefaultWeapon()

end

function PLAYER:SetModel()
	self.Player:SetModel("models/player/group01/male_01.mdl") --temp
end

--
-- Called when the player spawns
--
function PLAYER:Spawn()

	BaseClass.Spawn( self )
	
	self.Player:SetCrouchedWalkSpeed(0.32)

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

	return { model = "models/weapons/c_arms_citizen.mdl", skin = 1, body = "0000000" }

end

--
-- Reproduces the jump boost from HL2 singleplayer
--
local JUMPING

function PLAYER:StartMove( move )
	
	-- Only apply the jump boost in FinishMove if the player has jumped during this frame
	-- Using a global variable is safe here because nothing else happens between SetupMove and FinishMove
	if bit.band( move:GetButtons(), IN_JUMP ) ~= 0 and bit.band( move:GetOldButtons(), IN_JUMP ) == 0 and self.Player:OnGround() then
		JUMPING = true
	end
	
end

function PLAYER:FinishMove( move )
	
	-- If the player has jumped this frame
	if JUMPING then
		-- Get their orientation
		local forward = self.Player:EyeAngles()
		forward.p = 0
		forward = forward:Forward()
		
		-- Compute the speed boost
		
		-- HL2 normally provides a much weaker jump boost when sprinting
		-- For some reason this never applied to GMod, so we won't perform
		-- this check here to preserve the "authentic" feeling
		local speedBoostPerc = ( ( not self.Player:Crouching() ) and 0.5 ) or 0.1
		
		local speedAddition = math.abs( move:GetForwardSpeed() * speedBoostPerc )
		local maxSpeed = move:GetMaxSpeed() * ( 1 + speedBoostPerc )
		local newSpeed = speedAddition + move:GetVelocity():Length2D()
		
		-- Clamp it to make sure they can't bunnyhop to ludicrous speed
		if newSpeed > maxSpeed then
			speedAddition = speedAddition - (newSpeed - maxSpeed)
		end
		
		-- Reverse it if the player is running backwards
		if move:GetForwardSpeed() < 0 then
			speedAddition = -speedAddition
		end
		
		-- Apply the speed boost
		move:SetVelocity(forward * speedAddition + move:GetVelocity())
	end
	
	JUMPING = nil
	
end

player_manager.RegisterClass( "player_coop", PLAYER, "player_default" )
