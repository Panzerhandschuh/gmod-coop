HOOKS["InitPostEntity"] = function()
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByName("endlevel_relay")) do
		v:Fire("AddOutput","OnTrigger fakegameender,EndGame,,10,-1",0)
	end

	local tele = ents.Create("point_teleport")
	tele:SetName("elevator_tele")
	tele:SetPos(Vector(720, 2112, 204))
	tele:SetKeyValue("TeleportDestination", "elevator_tele")
	tele:SetKeyValue("target", "player")
	tele:Spawn()
	
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(507, 2112, 712))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByName("elevator_carbutton_top")) do
		v:Fire("AddOutput","OnPressed elevator_tele,Teleport,,0,1",0)
		v:Fire("AddOutput","OnPressed fcp1,SetAsCP,,0,1",0)
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if(k == "OnTrigger") then
		if (v == "door_03,Lock,,0,-1" || v == "door_05,Lock,,0,-1" || v == "garagedoor_01,Close,,0,-1" ) then
			return "!activator,AddOutput,dummykey 0,0,-1"
		end
	end
end