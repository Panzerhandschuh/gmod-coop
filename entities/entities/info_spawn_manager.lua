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
			timer.Simple(0.01,function() GAMEMODE.currentspawn = t end)
		end
	elseif(inputName == "TeleportPlayers") then
		local t = ents.FindByName(data)[1]
		if(t) then
			for k,v in pairs(player.GetAll()) do
				--if(v != activator) then
					v:SetPos(t:GetPos())
				--end
			end
		end
	end
end