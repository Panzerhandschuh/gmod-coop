--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

local AMMO_CONVERT = {}
AMMO_CONVERT["ammo_ar2"] = "ar2"
AMMO_CONVERT["ammo_ar2altfire"] = "ar2altfire"
AMMO_CONVERT["ammo_pistol"] = "pistol"
AMMO_CONVERT["ammo_smg1"] = "smg1"
AMMO_CONVERT["ammo_357"] = "357"
AMMO_CONVERT["ammo_xbowbolt"] = "xbowbolt"
AMMO_CONVERT["ammo_buckshot"] = "buckshot"
AMMO_CONVERT["ammo_rpg_round"] = "rpg_round"
AMMO_CONVERT["ammo_smg1_grenade"] = "smg1_grenade"
AMMO_CONVERT["ammo_grenade"] = "grenade"
AMMO_CONVERT["ammo_slam"] = "slam"

function ENT:KeyValue(key, value)
	if (!self.keyvalues) then
		self.keyvalues = {}
	end
	
	key = string.lower(key)
	if (string.find(key, "weapon") || string.find(key, "item") || string.find(key, "ammo")) then
		self.keyvalues[key] = value
	elseif (key == "startdisabled") then
		self.disabled = value
	end
end

function ENT:AcceptInput(inputName, activator, called, data)
	inputName = string.lower(inputName)
	if (inputName == "equipplayer") then
		if (!activator:IsValid()) then
			return
		end
		for k, v in pairs(self.keyvalues) do -- Loop through the items
			k = string.lower(k)
			if (string.StartWith(k, "ammo")) then
				if (AMMO_CONVERT[k]) then
					activator:GiveAmmo(100, AMMO_CONVERT[k])
				end
			else
			for i = 1, v, 1 do -- Loop through the number of item to equip
				local ent = activator:Give(k)
					timer.Simple(0.1, function()
						if (IsValid(ent) && !IsValid(ent:GetOwner())) then
							ent:Remove() -- Remove excess items to prevent spam
						end
					end)
				end
			end
		end
	elseif (inputName == "enable") then
		self.disabled = false
	elseif (inputName == "disable") then
		self.disabled = true
	elseif (inputName == "kill") then
		self:Remove()
	end
end