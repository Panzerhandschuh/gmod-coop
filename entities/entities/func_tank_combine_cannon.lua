--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:KeyValue(key, value)
	if (key == "ammotype" && value == "CombineHeavyCannon") then
		self:SetKeyValue("ammotype", "AR2")
	end
end