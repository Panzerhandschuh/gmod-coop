HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("math_counter_final")[1]
	counter.requiredPuzzles = 7
	counter:SetKeyValue("max", "7")
	
	local r1 = ents.Create("weapon_crowbar")
	r1:SetPos(Vector(-10144, 8064, -7292))
	r1:SetAngles(Angle(0, 0, 0))
	r1.ei = 0.1
	r1.oPos = Vector(-10144, 8064, -7292)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()

	local r2 = ents.Create("weapon_crowbar")
	r2:SetPos(Vector(-10144, 8064, -7292))
	r2:SetAngles(Angle(0, 0, 0))
	r2.ei = 0.2
	r2.oPos = Vector(-10144, 8064, -7292)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
	
	local r3 = ents.Create("weapon_crowbar")
	r3:SetPos(Vector(-10144, 8064, -7292))
	r3:SetAngles(Angle(0, 0, 0))
	r3.ei = 0.3
	r3.oPos = Vector(-10144, 8064, -7292)
	r3.oAng = Angle(0, 0, 0)
	r3:Spawn()
end