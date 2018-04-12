-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_ar2")

		ply:GiveAmmo(30, "ar2", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(564, 3191, 79))
	cp:SetAngles(Angle(0,270,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
		
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(344, 464, 108))
	cp:SetAngles(Angle(0,90,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-560, -432, 368))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp3")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-128, -1968, 412))
	cp:SetAngles(Angle(0,90,0))
	cp:SetName("fcp4")
	cp:Spawn()
	cp = nil
	
	local e = ents.FindByName("dropship_intro")[1]
	e:Fire("AddOutput","OnFinishedDropoff fcp1,SetAsCP,,0,1",0)
	e:Fire("AddOutput","OnFinishedDropoff player,Addoutput,origin 564 3191 79,0,1",0)
	ents.FindByName("counter_intro_dooropen")[1]:Fire("AddOutput","OnHitMax fcp2,SetAsCP,,4,1",0)
	ents.FindByName("counter_retreat_doorclose")[1]:Fire("AddOutput","OnHitMax fcp3,SetAsCP,,5,1",0)
	ents.FindByName("counter_insideWaves_doorClose")[1]:Fire("AddOutput","OnHitMax fcp4,SetAsCP,,10,1",0)
	ents.FindByName("finale_elevator_path2")[1]:Fire("AddOutput","OnPass fcp3,SetAsCP,,5,1",0)
	
	e = ents.FindByName("rescue_dropship_path5")[1]
	e:Fire("AddOutput","OnPass door_inside_top,Open,,60,1",0)
	e:Fire("AddOutput","OnPass door_inside_bottom,Open,,60,1",0)
	e:Fire("AddOutput","OnPass goal_assault_intoOutpost,Activate,,60,1",0)
	e:Fire("AddOutput","OnPass goal_follow_commander,Activate,,60,1",0)
	e:Fire("AddOutput","OnPass goal_follow_commander2,Activate,,60,1",0)
	e:Fire("AddOutput","OnPass goal_follow_commander3,Activate,,60,1",0)
	e:Fire("AddOutput","OnPass goal_follow_commander4,Activate,,60,1",0)
	e:Fire("AddOutput","OnPass goal_follow_commander5,Activate,,60,1",0)
	e:Fire("AddOutput","OnPass lcs_inside_retreat,Start,,60,1",0)
	
	ents.FindByName("trigger_finale_buttonroom_start")[1]:Fire("AddOutput","OnTrigger finale_door_long_open,Open,,80,1",0)
	
	e = ents.FindByName("trigger_finale_antgaurd_script")[1]
	e:Fire("AddOutput","OnTrigger lcs_finale_elevator_end,Start,,10,1",0)
	e:Fire("AddOutput","OnTrigger script_elevator_goend,MoveToPosition,,10,1",0)
	e:Fire("AddOutput","OnTrigger finale_elevator_antliongaurd_spawn,Enable,,10,1",0)
	e:Fire("AddOutput","OnTrigger finale_elevator_relate_antgaurd,ApplyRelationship,,10,1",0)
	e:Fire("AddOutput","OnTrigger finale_elevator_relate_antgaurd2,ApplyRelationship,,10,1",0)
	e:Fire("AddOutput","OnTrigger script_elevator_goend,BeginSequence,,12,1",0)
	e:Fire("AddOutput","OnTrigger finale_elevator_antspawner1,Enable,,14,1",0)
	e:Fire("AddOutput","OnTrigger lr_finale_elevator,Trigger,,100,1",0)
	e:Fire("AddOutput","OnTrigger script_elevator_goend2,MoveToPosition,,100,1",0)
	e:Fire("AddOutput","OnTrigger finale_elevator_scriptrepeater,Enable,,100,1",0)
	e:Fire("AddOutput","OnTrigger script_elevator_goend2,BeginSequence,,101,1",0)
	
	ents.FindByName("intro_commander")[1]:Fire("SetRelationship", "player D_LI 99", 0)
	
	ents.FindByName("insideWaves_servercommand")[1]:Remove()
	
	-- Remove crashing entities
	for k,v in pairs(ents.FindByName("ntemp_heli_0*")) do
		v:Remove()
	end
	
	-- Add new game end trigger
	ents.FindByName("finale_elevator_path3")[1]:Fire("AddOutput", "OnPass game_ender,EndGame,,24,1", 0)
end