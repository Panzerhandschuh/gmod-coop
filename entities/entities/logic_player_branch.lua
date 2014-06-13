ENT.Type = "point"

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "Test") then
		if(self.strict && self.value == #player.GetAll()) then
			self:TriggerOutput("OnTrue",activator)
		elseif(!self.strict && self.value <= #player.GetAll()) then
			self:TriggerOutput("OnTrue",activator)
		else
			self:TriggerOutput("OnFalse",activator)
		end
		return true
	end
end

function ENT:KeyValue(key, value)
	if(key == "StrictEqualto" && tonumber(value) == 1) then
		self.strict = true
		return true
	elseif(key == "InitialValue") then
		self.value = tonumber(value)
		return true
	elseif(key == "OnTrue" || key == "OnFalse") then
		self:StoreOutput(key, value)
		return true
	end
end