HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("des_pzombie3")[1]
	local pos = ent:GetPos()
	pos.z = pos.z - 16
	ent:SetPos(pos)

	ent = ents.FindByName("des_pzombie4")[1]
	pos = ent:GetPos()
	pos.z = pos.z - 16
	ent:SetPos(pos)
	
	for k,v in pairs(ents.FindByName("des*")) do
		pos = v:GetPos()
		pos.z = pos.z - 16
		v:SetPos(pos)
	end
end