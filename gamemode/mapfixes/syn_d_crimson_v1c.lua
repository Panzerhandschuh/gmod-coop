HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("tel_dest_z06b")[1]
	local pos = ent:GetPos()
	pos.z = pos.z - 16
	ent:SetPos(pos)

	ent = ents.FindByName("tel_dest_z06_null")[1]
	pos = ent:GetPos()
	pos.z = pos.z - 16
	ent:SetPos(pos)
	
	ent = ents.FindByName("tel_dest_z07")[1]
	pos = ent:GetPos()
	pos.z = pos.z - 16
	ent:SetPos(pos)
		
	ent = ents.FindByName("tel_dest_z06")[1]
	pos = ent:GetPos()
	pos.z = pos.z - 16
	ent:SetPos(pos)
end