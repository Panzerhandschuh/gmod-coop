HOOKS["PlayerSpawn"] = function(ply)
	-- Spawn player at the train
	local trainPos = ents.FindByName("train")[1]:GetPos()
	trainPos[3] = trainPos[3] + 32
	ply:SetPos(trainPos)
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("train")[1]:SetLagCompensated(true)
end