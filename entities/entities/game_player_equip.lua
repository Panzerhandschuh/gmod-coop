--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:KeyValue(key, value)
	if (!self.keyvalues) then
		self.keyvalues = {}
	end
	
	key = string.lower(key)
	if (string.find(key, "weapon") || string.find(key, "item") || string.find(key, "ammo")) then
		self.keyvalues[key] = value
	end
end

function ENT:AcceptInput(inputName, activator, called, data)
	inputName = string.lower(inputName)
	if (inputName == "equipactivator" || inputName == "equipplayer" || inputName == "use") then
		if (!activator:IsValid()) then
			return
		end
		for k, v in pairs(self.keyvalues) do -- Loop through the items
			for i = 1, v, 1 do -- Loop through the number of item to equip
				local ent = activator:Give(k)
				timer.Simple(0.1, function()
					if (IsValid(ent) && !IsValid(ent:GetOwner())) then
						ent:Remove() -- Remove excess items to prevent spam
					end
				end)
			end
		end
	elseif (inputName == "kill") then
		self:Remove()
	end
end