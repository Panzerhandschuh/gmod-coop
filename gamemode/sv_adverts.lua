local messages = {
	"Type 'rtv' if you want to change the map.",
	"Type 'nominate' if you want to choose a map to appear in the next vote.",
	"Type '!spectate' to spectate other players. You can rejoin the team by typing the command again.",
	"Type '!shop' or press F3 to access the points shop.",
	"If you are missing models and textures, try mounting Half-Life: Source, Half-Life 2: Episode 1, and Half-Life 2: Episode 2.",
	"Join our group at http://steamcommunity.com/groups/gmodcoop and https://discord.gg/3RbpsDpXbj to discuss the server, leave suggestions, or report bugs."
}

timer.Create("Advertising",120,0,function()
	PrintMessage(HUD_PRINTTALK, table.Random(messages))
end)