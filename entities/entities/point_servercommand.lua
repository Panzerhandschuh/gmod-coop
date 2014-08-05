--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:AcceptInput(inputName, activator, called, data)
	if (inputName == "Command") then
		if (string.find(data, "changelevel ") || string.find(data, "map ") || string.find(data, "disconnect")) then
			local next = GAMEMODE:GetNextSeriesMap()
			if (!next) then
				RTV.Start()
			else
				RunConsoleCommand("changelevel",next)
			end
		elseif (!string.find(data, "sk_") && !string.find(data, "mp_weaponstay")) then
			game.ConsoleCommand(data.."\n")
		end
	end
	return true
end
