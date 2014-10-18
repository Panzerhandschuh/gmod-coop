ENT.Type = "point"

function ENT:KeyValue(key, value)
	if(key == "StartDisabled" && tonumber(value) == 1) then
		self.disabled = true
	end
end

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "Enable") then
		self.disabled = false
		GAMEMODE.RefreshOCSpawn = true
	elseif(inputName == "Disable") then
		self.disabled = true
		GAMEMODE.RefreshOCSpawn = true
	end
end