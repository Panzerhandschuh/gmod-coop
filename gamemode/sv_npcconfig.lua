hook.Add("InitPostEntity", "LoadNpcConfigs", function()
	local npcConfig = "npc_config/" .. game.GetMap() .. ".txt", "DATA"
	if (!file.Exists(npcConfig, "DATA")) then return end

	local text = file.Read(npcConfig)
	local split = string.Explode("\r\n", text)

	local spawnerData = nil

	for _,line in pairs(split) do
		local kv = string.Explode(" ", line)
		local key = string.lower(kv[1])
		
		if (key == "{") then
			spawnerData = {}
		elseif (key == "npctype") then
			spawnerData.npcType = kv[2]
		elseif (key == "spawnfrequency") then
			spawnerData.spawnFrequency = kv[2]
		elseif (key == "maxlivechildren") then
			spawnerData.maxLiveChildren = kv[2]
		elseif (key == "maxnpccount") then
			spawnerData.maxNpcCount = kv[2]
		elseif (key == "additionalequipment") then
			spawnerData.weapon = kv[2]
		elseif (key == "origin") then
			spawnerData.pos = Vector(kv[2], kv[3], kv[4])
		elseif (key == "angles") then
			spawnerData.angles = Angle(kv[2], kv[3], kv[4])
		elseif (key == "}") then
			CreateNpcMaker(spawnerData)
		end
	end
end)

function CreateNpcMaker(spawnerData)
	local maker = ents.Create("npc_maker")
	maker:SetPos(spawnerData.pos)
	maker:SetAngles(spawnerData.angles)
	maker:SetKeyValue("StartDisabled", "0")
	maker:SetKeyValue("NPCType", spawnerData.npcType)
	maker:SetKeyValue("SpawnFrequency", spawnerData.spawnFrequency)
	maker:SetKeyValue("MaxLiveChildren", spawnerData.maxLiveChildren)
	maker:SetKeyValue("MaxNPCCount", spawnerData.maxNpcCount)
	maker:SetKeyValue("AdditionalEquipment", spawnerData.weapon)
	maker:Spawn()
	maker.isCustomMaker = true
end