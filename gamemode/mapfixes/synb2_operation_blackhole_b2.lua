HOOKS["InitPostEntity"] = function()
	local dest = ents.FindByName("dest1")[1]
	pos = dest:GetPos()
	pos.z = pos.z - 16
	dest:SetPos(pos)
	
	ents.FindByName("apc_01_viewcontroller")[1]:Remove()
end