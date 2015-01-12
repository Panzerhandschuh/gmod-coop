ENT.Type = "point"

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "ClearCheckPoint") then
		GAMEMODE.currentspawn = nil
		return true
	elseif(inputName == "MovePlayers") then
		for k,v in pairs(player.GetAll()) do
			if(v != activator) then
				v:SetPos(activator:GetPos())
			end
		end
		return true
	elseif(inputName == "SetCheckPoint") then
		local t = ents.FindByName(data)[1]
		if(t) then
			GAMEMODE.currentspawn = t
		end
	elseif(inputName == "TeleportPlayers") then
		local t = ents.FindByName(data)[1]
		if(t) then
			for k,v in pairs(player.GetAll()) do
				v:SetPos(t:GetPos())
			end
		end
	end
end