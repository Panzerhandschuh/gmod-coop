local AllMaps = {}

for k, v in pairs(GM:GetAllMaps()) do
	AllMaps[#AllMaps+1] = v
end

concommand.Add("listmaps", function(ply, cmd, args)
    for k, v in pairs(AllMaps) do
		ply:PrintMessage(HUD_PRINTCONSOLE, v)
	end
end)