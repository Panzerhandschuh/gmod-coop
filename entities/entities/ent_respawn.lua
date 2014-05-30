--gamemode by george and panzer

AddCSLuaFile()

ENT.Type 		= "anim"
ENT.Base 		= "base_anim"


function ENT:Initialize() --ripped ttt code cause it works
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

if SERVER then
	function ENT:Touch(v)
		if(v:IsPlayer()) then
			if(!self.respawntime || self.respawntime < CurTime()) then
				if(self.health && v:Health() < 100) then
					local h = math.min(100,v:Health()+self.health)
					v:SetHealth(h)
					self.respawntime = CurTime() + 10
					BroadcastLua("Entity("..self:EntIndex()..").respawntime = CurTime() + 10")
				elseif(self.rclass && GAMEMODE:CheckRespawnGive(v,self.rclass)) then
					GAMEMODE:GiveWep(v,self.rclass)
					self.respawntime = CurTime() + 10
					BroadcastLua("Entity("..self:EntIndex()..").respawntime = CurTime() + 10")
				elseif(self.aclass && GAMEMODE:PlayerAllowedItem(v,self.aclass)) then
					v:GiveAmmo(self.aamount,self.arclass)
					self.respawntime = CurTime() + 10
					BroadcastLua("Entity("..self:EntIndex()..").respawntime = CurTime() + 10")
				end
			end
		end
	end
else
	function ENT:Draw()
		if(!self.respawntime || self.respawntime < CurTime()) then
			self:DrawModel()
		end
	end
end