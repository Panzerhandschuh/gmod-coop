ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self.playercount = 0
	self.dontcount = {}
end

function ENT:StartTouch(ent)
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled) then
		self:TriggerOutput("OnStartTouch",ent)
		self:TriggerOutput("OnPlayerEntered",ent)
		self.playercount = self.playercount + 1
		
		if(self.playercount >= #player.GetAll() / 2) then
			self:TriggerOutput("OnAllPlayersEntered",ent)
		end
	end
	if(self.disabled) then
		if(!ent.latetouch) then ent.latetouch = {} end
		ent.latetouch[self:EntIndex()] = true
	end
end

function ENT:UpdatePlayerCount(total)
	if(self.playercount == total) then
		self:TriggerOutput("OnAllPlayersEntered",ent)
	end
end

function ENT:EndTouch(ent)
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled) then
		if(self.playercount && self.playercount > 0) then
			self.playercount = self.playercount - 1
			if(self.playercount == 0) then
				self:TriggerOutput("OnEndTouchAll",ent)
			end
		end
		self:TriggerOutput("OnEndTouch",ent)
		self:TriggerOutput("OnPlayerLeave",ent)
	end
	if(self.disabled) then
		if(!ent.latetouch) then ent.latetouch = {} end
		ent.latetouch[self:EntIndex()] = false
	end
end

function ENT:Touch(ent)
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled && ent.latetouch && ent.latetouch[self:EntIndex()]) then
		self:StartTouch(ent)
		ent.latetouch[self:EntIndex()] = false
	elseif(ent:IsPlayer() && ent:IsValid() && self.disabled && (!ent.latetouch || !ent.latetouch[self:EntIndex()])) then
		if(!ent.latetouch) then ent.latetouch = {} end
		ent.latetouch[self:EntIndex()] = true
	end
end

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "Enable") then
		self.disabled = false
		self.update = true
		return true
	elseif(inputName == "Disable") then
		self.disabled = true
		self.playercount = 0
		return true
	elseif(inputName == "Toggle") then
		if(self.disabled) then
			self.disabled = false
		else
			self.disabled = true
			self.playercount = 0
		end
		return true
	end
end

function ENT:KeyValue(key, value)
	if(key == "StartDisabled" && tonumber(value) == 1) then
		self.disabled = true
		return true
	elseif(string.sub(key,1,2) == "On") then
		self:StoreOutput(key, value)
		return true
	end
end