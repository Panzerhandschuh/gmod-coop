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
		local t = ents.FindByName(data)
		if(t) then
			local s = table.Random(t)
			GAMEMODE.currentspawn = s
		end
	elseif(inputName == "TeleportPlayers") then
		local t = ents.FindByName(data)
		if(t) then
			local s = table.Random(t)
			for k,v in pairs(player.GetAll()) do
				if(v != activator) then
					v:SetPos(s:GetPos())
				end
			end
		end
	end
end