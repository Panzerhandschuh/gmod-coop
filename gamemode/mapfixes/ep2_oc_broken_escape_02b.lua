-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")		

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(12, "buckshot", true)
		ply:GiveAmmo(30, "ar2", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("controllroom_door2_playerclip")[1]:Remove()
	ents.FindByName("controllroom_door2")[1]:Remove()
	--ents.FindByName("coolants_dest_relay4")[1]:SetKeyValue("StartDisabled", "0")
	for k,v in pairs(ents.FindByName("cooler3_blastdoor2")) do
		v:Remove()
	end
	for k,v in pairs(ents.FindByName("cooler3_blastdoor3")) do
		v:Remove()
	end
	
	local relay = ents.FindByName("coolants_dest_relay2")[1]
	relay:Fire("AddOutput","OnTrigger coolant4_door_trigger,Enable,,0,-1",0)
	relay:Fire("AddOutput","OnTrigger coolant4_door_spot,LightOff,,0,-1",0)
	relay:Fire("AddOutput","OnTrigger coolant4_door_spot,Color,0 255 0,0,-1",0)
	relay:Fire("AddOutput","OnTrigger coolant4_door_redlight,TurnOff,,0,-1",0)
	relay:Fire("AddOutput","OnTrigger coolant4_predfnd_tmp,ForceSpawn,,0,-1",0)
	relay:Fire("AddOutput","OnTrigger coolant4_door_spot,LightOn,,0,-1",0)
	relay:Fire("AddOutput","OnTrigger coolant4_door_greenlight,TurnOn,,0,-1",0)
	
	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(-7345, -1493, -6133)) then
			v:Fire("AddOutput","OnStartTouch coolants_dest_relay4,Enable,,0,-1",0)
		end
	end
	
	--ents.FindByName("cooler3_counter")[1]:Fire("AddOutput","OnHitMax coolants_dest_relay4,Enable,,0,-1",0)
	ents.FindByName("coolants_dest_relay3")[1]:Fire("AddOutput","OnTrigger 02b_d_mapchange,ChangeLevel,,15,-1",0)
end

lock = false

-- HOOKS["EntityKeyValue"] = function(e,k,v)
	-- if (e:GetName() == "cooler3_counter" && !lock) then
		-- lock = true
		-- print("falsdjfaklsjdfklajsfklajdfkljaskldfj")
		-- e:Fire("AddOutput","OnHitMax coolants_dest_relay4,Enable,,0,-1",0)
		-- e:Fire("AddOutput","OnHitMax coolants_dest_relay4,Trigger,,0.1,-1",0)
	-- end
-- end