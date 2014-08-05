ENT.Type = "point"

function ENT:Initialize()
	GAMEMODE.RespawnJeep = true
end

local br = false

local function SpawnJeep(self)
	local j = ents.Create("prop_vehicle_jeep_old")
	j:SetPos(self:GetPos())
	j:SetAngles(self:GetAngles())
	j:SetModel(self.jmodel)
	j:SetKeyValue("vehiclescript", self.jscript)
	j:Spawn()
	j:Activate()
	j.spawner = self
	if(!self.JeepCount) then self.JeepCount = 0 end
	self.JeepCount = self.JeepCount + 1
end

local function SpawnAirboat(self)
	local j = ents.Create("prop_vehicle_airboat")
	j:SetPos(self:GetPos())
	j:SetAngles(self:GetAngles())
	j:SetModel(self.jmodel)
	j:SetKeyValue("vehiclescript", self.jscript)
	j:Spawn()
	j:Activate()
	j.spawner = self
	if(!self.JeepCount) then self.JeepCount = 0 end
	self.JeepCount = self.JeepCount + 1
end

function ENT:Think()
	if(!self.JeepCount || self.JeepCount < #player.GetAll()) then
		br = false
		for k,v in pairs(ents.FindInSphere(self:GetPos(),150)) do
			if(v:GetClass() == "prop_vehicle_jeep" || v:GetClass() == "prop_vehicle_jeep") then
				br = true
				break
			end
		end
		if(!br && !timer.Exists(self:EntIndex().."jeeprespawn")) then
			timer.Create(self:EntIndex().."jeeprespawn", 2, 1, function()
				if (!self.jeep) then
					SpawnAirboat(self)
				else
					SpawnJeep(self)
				end
			end)
		elseif(br && timer.Exists(self:EntIndex().."jeeprespawn")) then
			timer.Destroy(self:EntIndex().."jeeprespawn")
		end
	end	
end