--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

local keyvalues = {}

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if (string.find(key, "weapon") || string.find(key, "item") || string.find(key, "ammo")) then
		keyvalues[key] = value
	end
end

function ENT:AcceptInput(inputName, activator, called, data)
	inputName = string.lower(inputName)
	if (inputName == "equipactivator" || inputName == "use") then
		for k, v in pairs(keyvalues) do
			for i = 1, v, 1 do
				local ent = activator:Give(k)
				timer.Simple(0.1, function()
					if (IsValid(ent) && !IsValid(ent:GetOwner())) then
						ent:Remove() -- Remove excess items to prevent spam
					end
				end)
			end
		end
	elseif (inputName == "Kill") then
		self:Remove()
	end
end