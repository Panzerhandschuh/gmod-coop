--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:AcceptInput(inputName, activator, called, data)
	if (inputName == "Command") then
		if (string.find(data, "disconnect")) then
			local next = GAMEMODE:GetNextSeriesMap()
			if (!next) then
				RTV.Start()
			else
				RunConsoleCommand("changelevel",next)
			end
		end
	end
	return true
end
