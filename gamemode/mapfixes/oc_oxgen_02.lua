-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_ar2")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(60, "ar2", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-4323, -2993, 156))
	cp:SetAngles(Angle(0,0,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil
	
	local e = ents.FindByName("areaportal4_trigger")[1]
	e:Fire("AddOutput","OnStartTouch fcp1,SetAsCP,,0,1",0)
	
	ents.FindByName("hurt_combineshieldwall1")[1]:Remove()
	ents.FindByName("trigger_combineshieldwall1")[1]:Remove()
	ents.FindByName("clip_combineshieldwall1")[1]:Remove()
	ents.FindByName("brush_combineshieldwall1")[1]:Remove()
end