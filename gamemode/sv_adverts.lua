local messages = {
	"Type 'rtv' if you want to change the map.",
	"Type 'nominate' if you want to choose a map to appear in the next vote.",
	"Join our group at http://steamcommunity.com/groups/gmodcoop to discuss the server, leave suggestions, or report bugs."
}

timer.Create("Advertising",120,0,function()
	PrintMessage(HUD_PRINTTALK, table.Random(messages))
end)