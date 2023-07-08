local AFK_TIME = 60

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in pairs (player.GetAll()) do
		if (ply:IsConnected()) then
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
		
			local afkTime = ply.NextAFK
			if (CurTime() >= afkTime && !ply.IsAFK) then
				ply.NextAFK = nil
				ply.IsAFK = true
				ply:ChatPrint("You are now AFK!")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	if (ply.IsAFK) then
		ply.IsAFK = false
		ply:ChatPrint("You are no longer AFK!")
	end
end)