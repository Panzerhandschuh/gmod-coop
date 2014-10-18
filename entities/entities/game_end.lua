--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "EndGame") then
		local next = GAMEMODE:GetNextSeriesMap()
		if(!next) then
			RTV.Start()
		else
			RTV.ChangeMap(next)
		end
	end
	return true
end