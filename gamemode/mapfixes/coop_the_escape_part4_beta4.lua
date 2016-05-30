HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("info_player_start")) do
		v:Remove()
	end
	
	ents.FindByName("rebel_rebel_filter")[1]:Remove()
	for k,v in pairs(ents.FindByClass("filter_activator_team")) do
		v:Remove()
	end
	
	for k,v in pairs(ents.FindByClass("trigger_vphysics_motion")) do
		v:Remove()
	end
	
	for k,v in pairs(ents.FindByClass("weapon_rpg")) do
		v:SetKeyValue("spawnflags", "4")
	end
	
	local r1 = ents.Create("weapon_rpg")
	r1:SetPos(Vector(-4957, -3826, 33))
	r1:SetAngles(Angle(0, 0, 0))
	r1:SetKeyValue("spawnflags", "4")
	r1.ei = 0.1
	r1.oPos = Vector(-4957, -3826, 33)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()
	
	local r2 = ents.Create("weapon_rpg")
	r2:SetPos(Vector(-4957, -3922, 33))
	r2:SetAngles(Angle(0, 0, 0))
	r1:SetKeyValue("spawnflags", "4")
	r2.ei = 0.2
	r2.oPos = Vector(-4957, -3922, 33)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(9664.01, -704.01, -360)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,15,-1",0)
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if ((string.find(e:GetName(), "wegsperre4*") || e:GetName() == "wegsperre3") && k == "OnDamaged") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end