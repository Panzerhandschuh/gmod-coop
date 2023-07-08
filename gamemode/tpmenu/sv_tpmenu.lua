util.AddNetworkString( "TPMenuOpen" )
util.AddNetworkString( "TPMenuTele" )
util.AddNetworkString( "TPMenuSuccess" )

hook.Add( "PlayerSpawn", "OpenMenu", function(ply)
	if ( GetGlobalFloat( "MapTimer_Start" ) + TPMenu.Wait >= CurTime() ) then
		return
	end

	timer.Simple( 0.5, function()
		TPMenu.Open( ply, false )
	end)
end)

--concommand.Add( "tp_menu", TPMenuOpenConCommand )

hook.Add( "PlayerSay", "TP Menu Chat Command", function( ply, text )

	local cmd = string.lower(text)
	if ( table.HasValue( TPMenu.ChatCommands, cmd ) ) then
		TPMenu.Open( ply, true )
		return ""
	end
	
end )

-- function TPMenuOpenConCommand( ply )
-- 	self:TPMenu.Open( ply, notify )
-- end

function TPMenu.Open( ply, notify )

	if ( string.match(game.GetMap(), "puzzle") ) then return end

	if ( !ply:Alive() || RTV.InVote ) then return end

	local activePlayers = {}
	for k, otherPly in pairs( player.GetAll() ) do
		if ( ply != otherPly && !otherPly.IsAFK ) then
			local entry = {}
			entry["name"] = otherPly:GetName()
			entry["steamid"] = otherPly:SteamID()

			table.insert( activePlayers, entry )
		end
	end

	if ( #activePlayers == 0 && notify == true ) then
		ply:PrintMessage( HUD_PRINTTALK, "There are no players to teleport to.")
		return
	end

	net.Start( "TPMenuOpen" )
		net.WriteTable( activePlayers )
	net.Send( ply )

end

net.Receive( "TPMenuTele", function( len, ply )
	local targetSteamID = net.ReadString()
	for k, v in pairs( player.GetAll() ) do
		if ( targetSteamID == v:SteamID() ) then
			if ( !ply:Alive() ) then
				ply:PrintMessage( HUD_PRINTTALK, "You must be alive to teleport to a player.")
				return
			end

			if ( !v:Alive() ) then
				ply:PrintMessage( HUD_PRINTTALK, "You cannot teleport to a dead player.")
				return
			end

			if ( ply:InVehicle() ) then
				ply:ExitVehicle()
			end

			ply:SetPos( v:GetPos() )

			net.Start( "TPMenuSuccess" )
			net.Send( ply )

			ply:PrintMessage( HUD_PRINTTALK, "You teleported to " .. v:GetName() .. ". Type !tpmenu to re-open the menu." )
			v:PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has teleported to you." )

			return
		end
	end

	ply:PrintMessage( HUD_PRINTTALK, "Failed to teleport to a player." )
end )