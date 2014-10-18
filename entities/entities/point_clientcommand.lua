--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:AcceptInput(inputName, activator, called, data)
	if (inputName == "Command") then
		if (string.StartWith(data, "disconnect")) then
			local next = GAMEMODE:GetNextSeriesMap()
			if (!next) then
				RTV.Start()
			else
				RTV.ChangeMap(next)
			end
		end
	end
	return true
end
