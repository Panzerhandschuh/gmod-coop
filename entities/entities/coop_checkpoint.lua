ENT.Type = "point"

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "SetAsCP") then
		GAMEMODE.currentspawn = self
	end
end