--gamemode by george and panzer

ENT.Type 		= "point"
ENT.Base 		= "base_point"

function ENT:Initialize()
	timer.Simple(0.1,function()
		self.text = ents.Create("game_text")
		self.text:SetKeyValue("spawnflags",self.kv.spawnflags)
		if(self.kv.message) then
			self.text:SetKeyValue("message",self.kv.message)
		end
		self.text:SetKeyValue("x",self.kv.x)
		self.text:SetKeyValue("y",self.kv.y)
		if(self.kv.effect) then
			self.text:SetKeyValue("effect",self.kv.effect)
		end
		self.text:SetKeyValue("color",self.kv.color)
		self.text:SetKeyValue("color2",self.kv.color2)
		self.text:SetKeyValue("fadein",self.kv.fadein)
		self.text:SetKeyValue("fadeout",self.kv.fadeout)
		self.text:SetKeyValue("holdtime",self.kv.holdtime)
		self.text:SetKeyValue("fxtime",self.kv.fxtime)
		self.text:SetKeyValue("channel",self.kv.channel)
		self.text:SetKeyValue("spawnflags","1")
		self.text:Spawn()
	end)
end

function ENT:KeyValue(key, value)
	if(!self.kv) then self.kv = {} end
	self.kv[key] = value
end

function ENT:AcceptInput(inputName, activator, called, data)
	if(inputName == "Display") then
		if(self.text && self.kv.message) then
			self.text:SetKeyValue("message",self.kv.message)
			self.text:Fire("Display","",0)
		end
	elseif(inputName == "DisplayText") then
		if(self.text) then
			self.text:SetKeyValue("message",data)
			self.text:Fire("Display","",0)
		end
	end
	return true
end