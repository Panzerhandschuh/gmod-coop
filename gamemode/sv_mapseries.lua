local MapGroups = {}

local SingleMaps = {}

function GM:LoadMapsConfig()
	local parse = file.Read("maps.txt")
	local split = string.Explode("\r\n",parse)
	local single = false
	local mapgroup = ""
	for k,v in pairs(split) do
		if(v == "[nolink]") then
			single = true
		elseif(string.sub(v,1,1) == "[" && string.match(v,"%[.*%]")) then
			single = false
			mapgroup = string.gsub(string.gsub(string.match(v,"%[.*%]"),"%[",""),"%]","")
		elseif(string.sub(v,1,2) != "//" && v != "") then
			if(single) then
				table.insert(SingleMaps,v)
			else
				if(!MapGroups[mapgroup]) then
					MapGroups[mapgroup] = {}
				end
				table.insert(MapGroups[mapgroup],v)
			end
		end
	end
end

function GM:GetRTVMaps()
	local t = table.Copy(SingleMaps)
	for k,v in pairs(MapGroups) do
		table.insert(t,v[1])
	end
	return t
end

function GM:GetAllMaps()
	local t = table.Copy(SingleMaps)
	for _,v in pairs(MapGroups) do
		for _,v2 in pairs(v) do
			table.insert(t,v2)
		end
	end
	return t
end

function GM:GetNextSeriesMap()
	local returnme = false --default return
	
	for k,v in pairs(MapGroups) do
		for k2,v2 in pairs(v) do
			if(v2 == game.GetMap()) then
				returnme = MapGroups[k][k2+1]
			end
		end
	end
	
	return returnme
end