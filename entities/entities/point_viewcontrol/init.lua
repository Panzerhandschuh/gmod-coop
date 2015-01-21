AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

ENT.inuse = false
ENT.initialspeed = 0
ENT.acceleration = 0
ENT.speed = 0
ENT.deceleration = 0
ENT.interpstart = nil
ENT.enabled = false
ENT.oc = false
ENT.syn = false
ENT.synb2 = false

local pathspeed = {}
local pathwait = {}

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate1x1.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_NOCLIP )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
	self:DrawShadow(false)
	self:SetNotSolid(true)
	self:SetNoDraw(true) 

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(true)
	end
	
	--[[local phys = self:GetPhysicsObject()
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:Sleep()
		self.Phys:EnableCollisions(false)
	end]]
	
	local c = self:GetColor()
	self:SetColor(255,255,255,0)
	
	self:SetRenderMode(RENDERMODE_TRANSTEXTURE)
	
	if(self.acceleration == 0) then
		self.acceleration = 500
	end
	
	if(self.deceleration == 0) then
		self.deceleration = 500
	end
	if(string.sub(game.GetMap(),1,5) == "synb2") then
		self.synb2 = true
	elseif(string.sub(game.GetMap(),1,3) == "syn") then
		self.syn = true
	elseif(string.find(game.GetMap(),"oc_")) then
		self.oc = true
	end
end

function ENT:UpdateTransmitState()
	if(self.inuse) then
		return TRANSMIT_ALWAYS
	else
		return TRANSMIT_NEVER
	end
end

function ENT:KeyValue(key,value)
	local okey = key
	key = string.lower(key)
	if(key == "wait") then
		self.wait = tonumber(value)
	elseif(key == "moveto") then
		self.spath = value
	elseif(key == "speed") then
		self.initialspeed = tonumber(value)
	elseif(key == "acceleration") then
		self.acceleration = tonumber(value)
	elseif(key == "targetattachment") then
		self.targetattach = value
	elseif(key == "target") then
		self.starget = value
	elseif(key == "interpolatepositiontoplayer") then
		self.plyinterp = tobool(value)
	elseif(key == "deceleration") then
		self.deceleration = tonumber(value)
	elseif(key == "spawnflags") then
		self.spawnflags = tonumber(value)
	elseif(okey == "OnEndFollow") then
		self:StoreOutput(okey,value)
	else
		return self.BaseClass:KeyValue(key,value)
	end

	return true;
end

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "Enable") then
		self.player = {activator}
		self:DoEnable()
		return true
	elseif(inputName == "Disable") then
		self.enabled = false
		self:DoDisable()
		return true
	end
end

function ENT:DoEnable()
	self.inuse = true
	if(self.oc || self.synb2 || (self.syn && bit.band(self.spawnflags,128)>0)) then
		print("cool")
		self.player = player.GetAll()
	end
	if(!self.player) then
		self.player = {player.GetAll()[1]} --1st player alternative so no crash incase spawnflags ^_^
	end

	for _,p in pairs(self.player) do
		if(!p:IsValid() || !p:IsPlayer()) then
			print("entity is not a player")
			continue
		end
	
			local view = p:GetViewEntity()
			if(view && view != p && view.GetClass && view:GetClass() == "point_viewcontrol") then
				if(view == self) then
				print("OK WHICH MORON ENABLED THIS TWICE IN A ROW!") -- XDDD
				continue
			else
				view:DoDisable()
			end
		end
		
		if(!(self.oc && bit.band(self.spawnflags,512)>0)) then
			p.nocdamage = true
		end
		
		if(!(self.oc && bit.band(self.spawnflags,1024)>0)) then
			p.nvistonpc = true --todo find out how to get this working
		end
		
		if(bit.band(self.spawnflags,32)>0) then
			p:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		end
		
		--if(bit.band(self.spawnflags,4)>0) then
		--	p:AddFlags(FL_FROZEN) -- freeze player (disabled for now cus it breaks sometimes)
		--end
	end
	
	self.interpstart = nil
	self.startpos = nil
	self.endpos = nil
	
	self.returntime = CurTime() + self.wait
	self.speed = self.initialspeed
	self.targetspeed = self.initialspeed
	
	if(bit.band(self.spawnflags,16)>0) then
		self.snaptogoal = true
	end
	
	local pc = table.Random(self.player)
	
	self.target = nil
	if(bit.band(self.spawnflags,2)>0) then
		self.target = pc
	elseif(self.starget) then
		local el = ents.FindByName(self.starget)
		if(el && el[1]) then
			self.target = el[1]
		end
	end
	
	if(self.target) then
		self.aindex = 0
		if(self.targetattach && self.targetattach != "") then
			self.aindex = self.target:LookupAttachment(self.targetattach)
			if(!self.aindex || self.aindex <= 0) then
				print("No valid attachment found.")
			end
		end
	end
	
	if(self.spath) then
		local el = ents.FindByName(self.spath)
		if(el && el[1]) then
			self.path = el[1]
		end
	else
		self.path = nil
	end
	
	self.stoptime = CurTime()
	if(self.path) then
		local st = self.path:GetSaveTable()
		if(st.speed && st.speed != 0) then
			self.targetspeed = st.speed
		end

		if(st.wait) then
			self.stoptime = self.stoptime + st.wait
		end
	end
	
	if(self.plyinterp) then
		self.startpos = pc:EyePos()
		self.endpos = self:GetPos()
		self.interpstart = CurTime()
		self:SetPos(self.startpos)
		self:SetAngles(Angle(pc:GetAngles().x,pc:GetAngles().y,0))
		self:SetLocalVelocity(Vector(0,0,0))
	elseif(bit.band(self.spawnflags,1)>0) then
		self:SetPos(pc:EyePos())
		self:SetAngles(Angle(pc:GetAngles().x,pc:GetAngles().y,0))
		self:SetLocalVelocity(pc:GetAbsVelocity())
	else
		self:SetLocalVelocity(Vector(0,0,0))
	end
	
	for _,p in pairs(self.player) do
		p:SetViewEntity(self)
	
		if(p:GetActiveWeapon() && p:GetActiveWeapon():IsValid()) then
			p:GetActiveWeapon():AddEffects(EF_NODRAW)
		end
		
		if(self.oc && bit.band(self.spawnflags,128)>0) then
			p:AddEffects(EF_NODRAW)
		end
	end
	
	self.enabled = true
	
	self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
	
	self.followtarget = false
	if(self.target) then
		self.followtarget = true
		self:NextThink(CurTime())
	end
	
	self.movedistance = 0
	self:DoMove()
end

function ENT:DoDisable()
	if(!self.inuse) then return end
	if(self.player) then
		for _,p in pairs(self.player) do
			if(!p:IsValid()) then continue end
			p:SetViewEntity(p)
			
			if(bit.band(self.spawnflags,32)>0) then
				p:SetCollisionGroup(COLLISION_GROUP_PLAYER)
			end

			p.nocdamage = false
			p.nvistonpc = false
			if(!p:Alive()) then continue end
			
			if(bit.band(self.spawnflags,4)>0) then
				p:RemoveFlags(FL_FROZEN)
			end
			
			if(p:GetActiveWeapon() && p:GetActiveWeapon():IsValid()) then
				p:GetActiveWeapon():RemoveEffects(EF_NODRAW)
			end
		
			if(self.oc && bit.band(self.spawnflags,128)>0) then
				p:RemoveEffects(EF_NODRAW)
			end
		end
		
		self.inuse = false
		self.followtarget = false
		self:TriggerOutput("OnEndFollow",self)
		
		self.returntime = CurTime()
		
		self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
	end
end

function ENT:ShouldUToggle(usetype,state)
	if (useType != USE_TOGGLE && useType != USE_SET) then
		if((state && useType == USE_ON) || (!state && useType == USE_OFF)) then
			return false
		end
	end
	return true
end

local lastthink = nil

function ENT:Think()
	if(self.enabled) then
		if(self.followtarget) then
			self:FollowTarget()
		end
		lastthink = CurTime()
		self:NextThink(CurTime())
		self:DoMove()
	end
	return true
end

function ENT:Use(activator, caller, useType, value)
	if(!self:ShouldUToggle(useType,self.inuse)) then return end
	
	if (self.inuse) then
		self.enabled = false
		self:DoDisable()
	else
		self.player = activator
		self:DoEnable()
	end
end

function ENT:FollowTarget()
	if(!self.player) then return end
	if(!self.target || !self.target:IsValid()) then
		self.enabled = false
		self:DoDisable()
		return
	end

	if(!(bit.band(self.spawnflags,8)>0) && (self.returntime < CurTime())) then
		self.enabled = false
		self:DoDisable()
		return
	end
	
	local goal
	if(self.aindex && self.aindex > 0) then
		local ap = self.target:GetAttachment(self.aindex)
		goal = (ap.Pos - self:GetPos()):Angle()
	else
		if(self.target && self.target:IsValid()) then
			goal = (self.target:GetPos() - self:GetPos()):Angle()
		else
			goal = self:GetAngles()
		end
	end
	
	if(self.snaptogoal) then
		self:SetAngles(goal)
		self.snaptogoal = false
	else
		--idk why its like this but i directly ported the source, even the source says why not use anglediff :L
		local ang = self:GetAngles()
		
		if(ang.y > 360) then ang.y = ang.y - 360 end
		if(ang.y < 0) then ang.y = ang.y + 360 end
		
		self:SetAngles(ang)
		
		local dx = goal.p - self:GetAngles().p
		local dy = goal.y - self:GetAngles().y
		
		if (dx < -180) then dx = dx + 360 end
		if (dx > 180) then dx = dx - 360 end
		
		if (dy < -180) then dy = dy + 360 end
		if (dy > 180) then dy = dy - 360 end
		
		self:SetLocalAngularVelocity(Angle(dx*40*FrameTime(),dy*40*FrameTime(),self:GetLocalAngularVelocity().r))
	end
	
	if(bit.band(self.spawnflags,4)>0) then
		self:SetLocalVelocity(self:GetVelocity()*0.8)
		if(self:GetVelocity():LengthSqr() < 100) then
			self:SetLocalVelocity(Vector(0,0,0))
		end
	end
end

local function SimpleSpline(inp)
	local sq = inp*inp
	
	return (3*sq-2*sq+inp)
end

function ENT:DoMove()
	if(bit.band(self.spawnflags,64)>0) then
		for _,p in pairs(self.player) do
			if(p && p:IsValid()) then
				if(p.cbuttons != p.obuttons) then
					self.enabled = false
					self:DoDisable()
					return
				end
			end
		end
	end
	
	if(self.path) then
		self.movedistance = self.movedistance - (self.speed*FrameTime())
		if(self.movedistance <= 0) then
			self.path:Input("InPass", self, self)
			local nspath = self.path:GetSaveTable().target
			
			self.path = nil
			if(nspath) then
				local el = ents.FindByName(nspath)
				if(el && el[1]) then
					self.path = el[1]
				end
			end
			
			if(!self.path) then
				self:SetLocalVelocity(Vector(0,0,0))
			else
				local st = self.path:GetSaveTable()
				if(st.speed && st.speed != 0) then
					self.targetspeed = st.speed
				end
		
				self.movedir = self.path:GetPos() - self:GetPos()
				self.movedistance = self.movedir:Length()
				self.movedir:Normalize()
				self.stoptime = CurTime()
				if(st.wait) then
					self.stoptime = self.stoptime + st.wait
				end
			end
		end
		
		if(self.stoptime > CurTime()) then
			self.speed = math.Approach(self.speed,0,self.deceleration*FrameTime())
		else
			self.speed = math.Approach(self.speed,self.targetspeed,self.acceleration*FrameTime())
		end
		
		local frac = 2*FrameTime()
		if(!self.oldvel) then
			self.oldvel = Vector(0,0,0)
		end
		self:SetAbsVelocity(((self.movedir * self.speed) * frac) + (self.oldvel * (1-frac)))
		self.oldvel = ((self.movedir * self.speed) * frac) + (self.oldvel * (1-frac))
	elseif(self.plyinterp) then
		local tt = (CurTime()-self.interpstart)/2
		
		if(tt >= 1) then
			self:SetOrigin(self.endpos)
			self:SetLocalVelocity(Vector(0,0,0))
			
			self.plyinterp = false
		else
			if(tt < 0) then print("WTF im getting out of this shit it ain't between 0 and 1") return end
			
			local nextpos = ((self.endpos - self.startpos)*SimpleSpline(tt)) + self.startpos
			local des = (nexpos - self:GetPos()) * (1/FrameTime())
			self:SetAbsVelocity(des)
		end
	end
end

hook.Add("ScalePlayerDamage","lolcamera",function(ply, hitgroup, dmginfo)
	if(ply.nocdamage) then
		dmginfo:ScaleDamage(0)
	end
end)

hook.Add("SetupMove", "lolcamera2", function(ply, mv, cmd)
	ply.cbuttons = mv:GetButtons()
	ply.obuttons = mv:GetOldButtons()
end)