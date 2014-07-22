--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:AcceptInput(inputName, activator, called, data)
	inputName = string.lower(inputName)
	if (inputName == "purchase") then
		self:TriggerOutput("OnPurchased", activator)
	elseif (inputName == "kill") then
		self:Remove()
	end
end

function ENT:KeyValue(k, v)
	if (k == "OnPurchased") then
		self:StoreOutput(k, v)
	end
end