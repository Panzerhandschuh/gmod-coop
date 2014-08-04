-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(30, "buckshot", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	local cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(56, 2648, -88))
	cp:SetAngles(Angle(0,90,0))
	cp:SetName("fcp1")
	cp:Spawn()
	cp = nil --no reference since its lua
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-296, 9356, -2230))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp2")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-1392, 9356, -2208))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp3")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-12064, 2064, 130))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp4")
	cp:Spawn()
	cp = nil
	
	cp = ents.Create("coop_checkpoint")
	cp:SetPos(Vector(-11664, 5376, -2000))
	cp:SetAngles(Angle(0,180,0))
	cp:SetName("fcp5")
	cp:Spawn()
	cp = nil
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(56, 2648, -64)) then
			v:Fire("AddOutput","OnTrigger fcp1,SetAsCP,,0,-1",0)
		elseif(v:GetPos() == Vector(-296, 9356, -2200)) then
			v:Fire("AddOutput","OnTrigger fcp2,SetAsCP,,0,-1",0)
		elseif(v:GetPos() == Vector(-12064, 2064, 384)) then
			v:Fire("AddOutput","OnTrigger fcp4,SetAsCP,,0,-1",0)
		elseif(v:GetPos() == Vector(-11664, 5376, -1936)) then
			v:Fire("AddOutput","OnTrigger fcp5,SetAsCP,,0,-1",0)
		end
	end
	
	local e = ents.FindByName("moving_grate_room_exitdoor")[1]
	e:Fire("AddOutput","OnOpen fcp3,SetAsCP,,0,1",0)
end