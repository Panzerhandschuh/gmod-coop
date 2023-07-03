hook.Add("InitPostEntity", "LoadEntityConfigs", function()
	local entityConfig = "entity_config/" .. game.GetMap() .. ".txt", "DATA"
	if (!file.Exists(entityConfig, "DATA")) then return end

	local text = file.Read(entityConfig)
	local split = string.Explode("\r\n", text)

	local entData = nil

	for _,line in pairs(split) do
		local kv = string.Explode(" ", line)
		local key = string.lower(kv[1])
		
		if (key == "{") then
			entData = {}
			entData.weapon = ""
		elseif (key == "}") then
			CreateEntity(entData)
		elseif (line != "") then
			local splitStart, splitEnd = string.find(line, " ")
			local key = string.lower(string.sub(line, 0, splitStart - 1))
			local value = string.sub(line, splitEnd + 1)

			entData[key] = value
		end
	end
end)

function CreateEntity(entData)
	local entity = ents.Create(entData["classname"])
	for k, v in pairs(entData) do
		entity:SetKeyValue(k, tostring(v))
	end

	if (string.sub(entData["classname"], 1, 7) == "weapon_" || string.sub(entData["classname"], 1, 5) == "item_") then
		entity.ei = entity:EntIndex()
		entity.oPos = entity:GetPos()
		entity.oAng = entity:GetAngles()
	end
	
	entity.isCustomEntity = true

	entity:Spawn()
end
