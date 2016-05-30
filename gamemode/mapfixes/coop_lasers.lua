HOOKS["InitPostEntity"] = function()
	ents.FindByName("music_button")[1]:Remove()

	local r1 = ents.Create("weapon_rpg")
	r1:SetPos(Vector(563, 4494, 13))
	r1:SetAngles(Angle(0, 32.5, 0))
	r1.ei = 0.1
	r1.oPos = Vector(563, 4494, 13)
	r1.oAng = Angle(0, 32.5, 0)
	r1:Spawn()
	
	local r2 = ents.Create("weapon_rpg")
	r2:SetPos(Vector(627, 4542, 13))
	r2:SetAngles(Angle(0, 32.5, 0))
	r2.ei = 0.2
	r2.oPos = Vector(627, 4542, 13)
	r2.oAng = Angle(0, 32.5, 0)
	r2:Spawn()
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
end

HOOKS["OnEntityCreated"] = function(ent)
	if (ent:GetClass() == "npc_helicopter") then
		ent:Fire("AddOutput","OnDeath fakegameender,EndGame,,10,-1",0)
	end
end