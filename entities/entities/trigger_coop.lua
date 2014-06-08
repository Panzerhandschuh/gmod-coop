ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self.playercount = 0
	SetGlobalInt(self:EntIndex().."_RequiredPlayers",self.players)
end

function ENT:StartTouch(ent)
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled && self.players) then
		self.playercount = self.playercount + 1
		SetGlobalInt(self:EntIndex().."_PlayerCount",self.playercount)
		if(!self.over) then
			ent:SetNWInt("InCoopTrigger",self:EntIndex())
		end
		
		if(self.playercount >= self.players) then
			self:TriggerOutput("OnPlayersIn", ent)
			self.over = true
			for k,v in pairs(player.GetAll()) do
				if(tonumber(v:GetNWInt("InCoopTrigger",0)) == self:EntIndex()) then
					v:SetNWInt("InCoopTrigger",0)
				end
			end
		elseif(self.over && self.playercount <= self.players) then
			self:TriggerOutput("OnPlayersOut", ent)
			self.over = false
		end
	end
end

function ENT:EndTouch(ent)
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled && self.players) then
		self.playercount = self.playercount - 1
		SetGlobalInt(self:EntIndex().."_PlayerCount",self.playercount)
		ent:SetNWInt("InCoopTrigger",0)
		
		if(self.playercount >= self.players) then
			self:TriggerOutput("OnPlayersIn", ent)
			self.over = true
		elseif(self.over && self.playercount <= self.players) then
			self:TriggerOutput("OnPlayersOut", ent)
			self.over = false
		end
	end
end

function ENT:UpdatePlayerCount(total)
	if(self.percentage) then
		local m = self.oplayers/100
		self.players = math.ceil(total*m)
		SetGlobalInt(self:EntIndex().."_RequiredPlayers",self.players)
		
		--[[if(self.playercount >= self.players) then
			self:TriggerOutput("OnPlayersIn")
			self.over = true
		elseif(self.over && self.playercount <= self.players) then
			self:TriggerOutput("OnPlayersOut")
			self.over = false
		end]]
	end
end

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "Enable") then
		self.disabled = false
		return true
	elseif(inputName == "Disable") then
		self.disabled = true
		return true
	elseif(inputName == "Toggle") then
		if(self.disabled) then
			self.disabled = false
		else
			self.disabled = true
		end
		return true
	end
end

function ENT:KeyValue(key, value)
	if(key == "PlayerValue") then
		self.players = tonumber(value)
		self.oplayers = tonumber(value)
		return true
	elseif(key == "CountType" && tonumber(value) == 1) then
		self.percentage = true
		return true
	elseif(key == "UseHud" && tonumber(value) == 1) then
		self.hud = true
		return true
	elseif(key == "StartDisabled" && tonumber(value) == 1) then
		self.disabled = true
		return true
	elseif key == "OnPlayersIn" or key == "OnPlayersOut" then
		self:StoreOutput(key, value)
		return true
	end
end