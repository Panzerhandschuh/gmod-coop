RTV.VTab = {}
for i = 1, 9 do
	RTV.VTab["MAP_"..i] = 0
end

RTV.Limit = math.Clamp( RTV.Limit, 2, 8 )

RTV.Maps = {}
RTV.NominateList = {}
RTV.Nominated = {}

RTV.TTT = false

RTV.TotalVotes = 0

RTV._ActualWait = CurTime() + RTV.Wait

local get = 0

local files, dirs = file.Find( "maps/*.bsp", "GAME" )

GM:LoadMapsConfig()

--if RTV.UsePrefixes then
for k,v in pairs(GM:GetAllMaps()) do
	if v == game.GetMap() then continue end
	RTV.NominateList[#RTV.NominateList+1] = v
end

for k, v in RandomPairs(GM:GetAllMaps()) do
	if v == game.GetMap() then continue end
	if get > RTV.Limit then break end
	RTV.Maps[#RTV.Maps+1] = v
	get = get + 1
end
--end

SetGlobalBool( "In_Voting", false )
RTV.InVote = false

util.AddNetworkString( "RTVVTab" )
util.AddNetworkString( "RTVMaps" )
util.AddNetworkString( "RTVNominate" )

hook.Add( "Initialize", "Check for TTT GM", function()
	
	
	RTV.TTT = string.find( string.lower(gmod.GetGamemode().Name), "trouble in terror" )
end )

hook.Add( "PlayerInitialSpawn", "SendList", function(ply)
	net.Start("RTVNominate")
	net.WriteTable(RTV.NominateList)
	net.Send(ply)
end)

function RTV.ShouldChange()
	return RTV.TotalVotes >= math.Round(#player.GetHumans()*0.6)
end

function RTV.RemoveVote()
	RTV.TotalVotes = math.Clamp( RTV.TotalVotes - 1, 0, math.huge )
end

function RTV.Start()
	if(!RTV.rtved) then
		TIMER:Finish()
	end
	RTV.rtved = true

	local nom = {}
	
	local i = 0
	for k,v in RandomPairs(RTV.Nominated) do
		if(!nom[v]) then
			i = i + 1
			RTV.Maps[i] = v
			nom[v] = true
		end
	end
	
	RTV.Nominated = {}

	SetGlobalBool( "In_Voting", true )
	RTV.InVote = true

	for k, v in pairs( player.GetAll() ) do
		net.Start( "RTVMaps" )
			net.WriteTable( RTV.Maps )
		net.Send( v )
		umsg.Start( "RTVoting", v )
		umsg.End()
		SetGlobalBool( "In_Voting", true )
	end
	
	timer.Simple( 30, function()
		RTV.Finish()
	end )

end

function RTV.ChangeMap( map )

	if not map then
		RTV.ChangingMaps = false
		return 
	end

	if RTV.TTT then

		PrintMessage( HUD_PRINTTALK, "Changing the map to "..map.." after the current round." )

		hook.Add( "TTTPrepareRound", "RTV - Change Map", function()

			RunConsoleCommand( "GM", GM.FolderName )
			RunConsoleCommand( "changelevel", map )
			RTV.ChangingMaps = false

		end )

	else

		PrintMessage( HUD_PRINTTALK, "Changing the map to "..map.." now." )

		if(!RTV.rtved) then
			TIMER:Finish()
		end
		
		timer.Simple( 5, function()

			RunConsoleCommand( "changelevel", map )
			RTV.ChangingMaps = false

		end )

	end

end

concommand.Add( "rtv_vote", function( ply, cmd, args )

	if not (ply and ply:IsValid()) then return end

	if not RTV.InVote then
		ply:PrintMessage( HUD_PRINTTALK, "There is no vote in progress." )
		return
	end

	if ply.MapVoted then
		ply:PrintMessage( HUD_PRINTTALK, "You have already voted!" )
		return
	end

	local vote = args[1]

	if not vote then
		ply:PrintMessage( HUD_PRINTTALK, "What are you doing?" )
		return
	end

	if not tonumber(vote) then
		ply:PrintMessage( HUD_PRINTTALK, "What are you doing?" )
		return
	end

	vote = math.Clamp( tonumber(vote), 1, #RTV.Maps )

	RTV.VTab["MAP_"..vote] = RTV.VTab["MAP_"..vote] + 1
	net.Start( "RTVVTab" )
		net.WriteTable( RTV.VTab )
	net.Send( player.GetAll() )
	ply.MapVoted = vote
	ply:PrintMessage( HUD_PRINTTALK, "You have voted for "..RTV.Maps[vote].."! Type !revote to change your vote." )

end )

function RTV.Finish()

	SetGlobalBool( "In_Voting", false )
	RTV.InVote = false
	RTV.TotalVotes = 0

	for k, v in pairs( player.GetAll() ) do
		v.RTVoted = false
		v.MapVoted = nil
	end

	local top = 0
	local winner = nil

	for k,v  in pairs( RTV.VTab ) do

		if v > top then
			top = v
			winner = k
		end

		RTV.VTab[k] = 0

	end

	if top <= 0 then

		PrintMessage( HUD_PRINTTALK, "Vote failed! Choosing a random map." )
		
		RTV.ChangingMaps = true
		RTV.ChangeMap( RTV.Maps[math.random(1,#RTV.Maps)] )

	elseif winner then

		winner = string.gsub( winner, "MAP_", "" )

		winner = math.Clamp( tonumber(winner) or 1, 1, #RTV.Maps )
		PrintMessage( HUD_PRINTTALK, "The winning map is "..RTV.Maps[winner].."!" )
		RTV.ChangingMaps = true
		RTV.ChangeMap( RTV.Maps[winner] )

	else

		PrintMessage( HUD_PRINTTALK, "Voting fucked up. RIP" )

	end

end

function RTV.AddVote( ply )

	if RTV.CanVote( ply ) then
		RTV.TotalVotes = RTV.TotalVotes + 1
		ply.RTVoted = true
		MsgN( ply:Nick().." has voted to Rock the Vote." )
		PrintMessage( HUD_PRINTTALK, ply:Nick().." has voted to Rock the Vote. ("..RTV.TotalVotes.."/"..math.Round(#player.GetHumans()*0.6)..")" )

		if RTV.ShouldChange() then
			RTV.rtved = true
			RTV.Start()
		end
	end

end

hook.Add( "PlayerDisconnected", "Remove RTV", function( ply )

	if ply.RTVoted then
		RTV.RemoveVote()
	end

end )

function RTV.CanVote( ply )

	if RTV._ActualWait >= CurTime() then
		return false, "You must wait a bit before voting!"
	end

	if RTV.InVote then
		return false, "There is currently a vote in progress!"
	end

	if ply.RTVoted then
		return false, "You have already voted to Rock the Vote!"
	end

	if RTV.ChangingMaps then
		return false, "There has already been a vote, the map is going to change!"
	end

	return true

end

function RTV.CanReVote( ply )

	if !RTV.InVote then
		return false, "There is no vote in progress!"
	end

	if !ply.MapVoted then
		return false, "You have not voted yet!"
	end

	if RTV.ChangingMaps then
		return false, "There has already been a vote, the map is going to change!"
	end

	return true

end

function RTV.StartVote( ply )

	local can, err = RTV.CanVote(ply)

	if not can then
		ply:PrintMessage( HUD_PRINTTALK, err )
		return
	end

	RTV.AddVote( ply )

end

function RTV.Revote( ply )

	local can, err = RTV.CanReVote(ply)
	
	if not can then
		ply:PrintMessage( HUD_PRINTTALK, err )
		return
	end
	
	-- Remove vote
	RTV.VTab["MAP_"..ply.MapVoted] = RTV.VTab["MAP_"..ply.MapVoted] - 1
	net.Start( "RTVVTab" )
		net.WriteTable( RTV.VTab )
	net.Send( player.GetAll() )
	umsg.Start( "RTRevoting", ply )
	umsg.End()
	ply:PrintMessage( HUD_PRINTTALK, "You have removed your vote for "..RTV.Maps[ply.MapVoted].."!" )
	ply.MapVoted = nil

end

concommand.Add( "rtv_start", RTV.StartVote )

function RTV.NominateMap( ply,cmd,map )
	if(!map || !map[1] || type(map[1]) != "string" || (map && map[2])) then return end
	map = map[1]
	if(!table.HasValue(RTV.NominateList,map)) then
		ply:PrintMessage( HUD_PRINTTALK, "Map "..map.." not found!")
		return
	end
	
	if RTV.InVote then
		ply:PrintMessage( HUD_PRINTTALK, "There is currently a vote in progress!")
		return
	end

	if RTV.ChangingMaps then
		ply:PrintMessage( HUD_PRINTTALK, "There has already been a vote, the map is going to change!")
		return 
	end
	
	local u = ply:UniqueID()
	if(!RTV.Nominated[u]) then
		PrintMessage( HUD_PRINTTALK, ply:Nick().." has nominated "..map.."!")
	elseif (RTV.Nominated[u] != map) then
		PrintMessage( HUD_PRINTTALK, ply:Nick().." has changed his nomination from "..RTV.Nominated[u].." to "..map.."!")
	end

	RTV.Nominated[u] = map
end

concommand.Add( "rtv_nominate", RTV.NominateMap )

hook.Add( "PlayerSay", "RTV Chat Commands", function( ply, text )

	local cmd = string.lower(text)
	if table.HasValue( RTV.ChatCommands, cmd ) then
		RTV.StartVote( ply )
		return ""
	end
	
	if (cmd == "revote" || cmd == "!revote" || cmd == "/revote") then
		RTV.Revote( ply )
		return ""
	end
	
	local s = string.sub(cmd,1,9)
	local s2 = string.sub(cmd,1,8)
	if(s2 == "nominate" || s == "!nominate" || s == "/nominate") then
		local im = string.Explode(" ",cmd)
		if(im && im[2]) then
			if(type(im[2]) != "string") then return ""
			elseif(#im>2) then return "" end
			RTV.NominateMap( ply,nil,{im[2]})
			return ""
		else
			umsg.Start( "RTNom", ply )
			umsg.End()
			return ""
		end
	end
end )