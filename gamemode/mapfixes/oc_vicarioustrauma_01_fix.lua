HOOKS["InitPostEntity"] = function()
	ents.FindByClass("point_viewcontrol")[1]:Remove()
	ents.FindByName("morbut")[1]:Remove()
	ents.FindByName("turreth")[1]:SetKeyValue("ammo_count", "-1")
	ents.FindByName("sh")[1]:SetKeyValue("spawnflags", "5")
	ents.FindByName("ss")[1]:Remove()
	
	local board = ents.FindByName("board")[1]
	board:Fire("AddOutput","OnPlayerUse butf,Unlock,,0,1",0)
	
	for k,v in pairs(ents.FindByClass("prop_physics")) do
		if (v:GetPos() == Vector(2576, -362, -490) || v:GetPos() == Vector(2576, -272, -490)) then
			local pos = v:GetPos()
			pos.z = pos.z - 16
			v:SetPos(pos)
		end
	end
end