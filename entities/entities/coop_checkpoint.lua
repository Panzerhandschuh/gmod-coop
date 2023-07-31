ENT.Type = "point"

function ENT:KeyValue(key, value)
	if (!self.keyvalues) then
		self.keyvalues = {}
	end
	
	key = string.lower(key)
	self.keyvalues[key] = value
end

function ENT:AcceptInput(inputName, activator, called, data)
	if (inputName == "SetAsCP") then
		GAMEMODE.currentspawn = self
		ActivateCP(self, nil)
	end
end

function ENT:Think()
	if (!self.keyvalues || !self.keyvalues["radius"] || self.hasActivated) then
		return
	end

	for _, ply in pairs(player.GetAll()) do
		local radius = tonumber(self.keyvalues["radius"])
		if (ply:GetPos():Distance(self:GetPos()) < radius) then
			ActivateCP(self, ply)
			return
		end
	end
end

function ActivateCP(self, ply)
	if (self.keyvalues) then
		if (self.keyvalues["updatecp"] == "1") then
			GAMEMODE.currentspawn = self
		end

		if (self.keyvalues["moveplayers"] == "1") then
			for _, ply2 in pairs(player.GetAll()) do
				if (ply != ply2) then
					ply2:SetPos(self:GetPos())
				end
			end
		end
	end
	
	self.hasActivated = true
	PrintMessage(HUD_PRINTTALK, "Checkpoint reached...")
end