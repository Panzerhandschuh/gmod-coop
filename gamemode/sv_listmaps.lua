local AllMaps = {}

local unsortedMaps = GM:GetAllMaps()

local maps = {}
for k, v in ipairs(unsortedMaps) do
	maps[v] = k
end

table.sort(maps)
for k, v in SortedPairs(maps) do
    AllMaps[#AllMaps + 1] = k
end

concommand.Add("listmaps", function(ply, cmd, args)
    for k, v in pairs(AllMaps) do
		ply:PrintMessage(HUD_PRINTCONSOLE, v)
	end
end)