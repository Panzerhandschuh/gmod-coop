AddCSLuaFile()

ENT.Type = "anim"

local VALID_AMMO = {}
VALID_AMMO["357"] = true
VALID_AMMO["ar2"] = true
VALID_AMMO["ar2altfire"] = true
VALID_AMMO["xbowbolt"] = true
VALID_AMMO["pistol"] = true
VALID_AMMO["smg1"] = true
VALID_AMMO["smg1_grenade"] = true
VALID_AMMO["buckshot"] = true
VALID_AMMO["rpg_round"] = true

function ENT:Initialize()
	if(SERVER) then
		self:SetModel(self.cmodel)
		
		if(!VALID_AMMO[string.lower(self.AmmoType)]) then
			self:Remove()
		end
	end

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_BBOX )

	self:SetCollisionGroup( COLLISION_GROUP_WEAPON)
	local b = 26
	self:SetCollisionBounds(Vector(-b, -b, -b), Vector(b,b,b))

	if SERVER then
		self:SetTrigger(true)
	end
	
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:PlayerCanPickup(ply)
	if ply == self:GetOwner() then return false end

	local ent = self
	local phys = ent:GetPhysicsObject()
	local spos = phys:IsValid() and phys:GetPos() or ent:OBBCenter()
	local epos = ply:GetShootPos()

	local tr = util.TraceLine({start=spos, endpos=epos, filter={ply, ent}, mask=MASK_SOLID})

	return tr.Fraction == 1.0
end

function ENT:Touch(ent)
	if SERVER && !self.taken then
		if (ent:IsValid() and ent:IsPlayer() and self:PlayerCanPickup(ent) and GAMEMODE:PlayerCanPickupItem(ent, self)) then
			self.taken = true
			ent:GiveAmmo(self.AmmoAmount,self.AmmoType)
			self:Remove()
		end
	end
end

function ENT:KeyValue(key,value)
	if(key == "model") then
		self.cmodel = value
	elseif(key == "Amount") then
		self.AmmoAmount = tonumber(value)
	elseif(key == "AmmoName") then
		self.AmmoType = value
	end
end