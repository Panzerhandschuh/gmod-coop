HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(-564, -7738.5, 490)) then
			v:Fire("AddOutput","OnStartTouch cp1_relay,Trigger,,0,1",0)
		end
	end

	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(596, -7738.5, 490)) then
			v:Fire("AddOutput","OnStartTouch cp1_relay,Trigger,,0,1",0)
		end
	end

	local cp1 = ents.Create("coop_checkpoint")
	cp1:SetKeyValue("targetname", "cp1")
	cp1:SetKeyValue("updatecp", "1")
	cp1:SetKeyValue("radius", "0")
	cp1:SetKeyValue("moveplayers", "0")
	cp1:SetKeyValue("Angles", "0 0 0")
	cp1:SetKeyValue("Origin", "-969, -7611, 438")
    cp1:Spawn()

	local cp1_relay = ents.Create("logic_relay")
	cp1_relay:SetKeyValue("targetname", "cp1_relay")
	cp1_relay:SetKeyValue("spawnflags", "1")
	cp1_relay:SetKeyValue("StartDisabled", "0")
	cp1_relay:SetKeyValue("Origin", "-896, -7807, 449")
	cp1_relay:Fire("AddOutput","OnTrigger cp1,SetAsCP,,0,1",0)
    cp1_relay:Spawn()
end