ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:StartTouch(ent)
	print("start touch")
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled) then
		local next = GAMEMODE:GetNextSeriesMap()
		if(!next) then
			RTV.Start()
		else
			RunConsoleCommand("changelevel", next)
		end
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
	if(key == "StartDisabled" && tonumber(value) == 1) then
		self.disabled = true
		return true
	end
end