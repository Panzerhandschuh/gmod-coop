-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
	timer.Simple( 0.1, function()
	ply:StripWeapons()
	end )
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("train")[1]:SetLagCompensated(true)
end

--[[
HOOKS["PlayerSpawn"] = function(ply)
	-- Spawn player at the train
	local trainPos = ents.FindByName("train")[1]:GetPos()
	trainPos[3] = trainPos[3] + 32
	ply:SetPos(trainPos)
end
]]-- this is done within the map now, can probably delete this