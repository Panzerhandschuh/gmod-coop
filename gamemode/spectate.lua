function StartSpectate(ply)
	--ply:ResetViewRoll()
	ply:SetTeam(TEAM_SPECTATOR)
	ply:Kill()
	local alive = GetAlivePlayers()
	if (#alive < 1) then
		ply:Spectate(OBS_MODE_ROAMING)
		ply.spec_mode = OBS_MODE_ROAMING
		ply:SpectateEntity(nil)
	end
	
	local target = table.Random(alive)
	if (IsValid(target)) then
		ply:Spectate(OBS_MODE_CHASE)
		ply.spec_mode = OBS_MODE_CHASE
		ply:SpectateEntity(target)
	end
end

function StopSpectate(ply)
	ply:SetTeam(TEAM_UNASSIGNED)
	ply:Spectate(OBS_MODE_NONE)
	ply.spec_mode = OBS_MODE_NONE
	ply:UnSpectate()
	ply:Spawn()
end

function GM:PlayerSay(sender, text, teamChat)
	local cmd = string.lower(text)
	cmd = string.sub(cmd, 1, 9)
	if (cmd == "!spectate" || cmd == "/spectate") then
		if (!IsSpec(sender)) then
			StartSpectate(sender)
		else
			StopSpectate(sender)
		end
	end
end

concommand.Add("spectate", function(ply)
	if (!IsSpec(ply)) then
		StartSpectate(ply)
	else
		StopSpectate(ply)
	end
end)

-- function GM:PlayerDeathThink(ply)
	-- return !IsSpec(ply)
-- end

function GM:KeyPress(ply, key)
	if (!IsValid(ply) || !IsSpec(ply)) then 
		return
	end
	
	-- Spectator keys
	if (key == IN_ATTACK) then -- Spectate next guy
		local target = GetNextAlivePlayer(ply)
		ply:Spectate(ply.spec_mode)
		ply:SpectateEntity(target)
		
		if IsValid(target) then
			ply:SetPos(target:EyePos())
		end
	elseif key == IN_ATTACK2 then -- Change spectate mode
		if (ply.spec_mode == OBS_MODE_ROAMING) then
			ply.spec_mode = OBS_MODE_CHASE
		elseif (ply.spec_mode == OBS_MODE_CHASE) then
			ply.spec_mode = OBS_MODE_IN_EYE
		else -- Current in eye or some other mode, default to roaming
			ply.spec_mode = OBS_MODE_ROAMING
		end
		ply:Spectate(ply.spec_mode)
	end
end

function IsSpec(ply)
	return ply:Team() == TEAM_SPECTATOR
end

function GetAlivePlayers()
   local alive = {}
   for k, p in pairs(player.GetAll()) do
      if (IsValid(p) and p:Alive()) then
         table.insert(alive, p)
      end
   end

   return alive
end

function GetNextAlivePlayer(ply)
   local alive = GetAlivePlayers()

   if #alive < 1 then return nil end

   local prev = nil
   local choice = nil

   if IsValid(ply) then
      for k,p in pairs(alive) do
         if prev == ply then
            choice = p
         end

         prev = p
      end
   end

   if not IsValid(choice) then
      choice = alive[1]
   end

   return choice
end