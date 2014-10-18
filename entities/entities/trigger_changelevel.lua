ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:StartTouch(ent)
	if(ent:IsPlayer() && ent:IsValid() && !self.disabled) then
		ChangeLevel()
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
	elseif(inputName == "ChangeLevel") then
		ChangeLevel()
		return true
	end
end

function ENT:KeyValue(key, value)
	if(key == "StartDisabled" && tonumber(value) == 1) then
		self.disabled = true
		return true
	end
end

function ChangeLevel()
	local next = GAMEMODE:GetNextSeriesMap()
	if(!next) then
		RTV.Start()
	else
		RTV.ChangeMap(next)
	end
end