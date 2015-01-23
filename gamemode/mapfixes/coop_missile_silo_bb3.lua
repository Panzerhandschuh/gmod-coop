HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("filter_activator_team")) do
		v:Remove()
	end
	
	for k,v in pairs(ents.FindByName("teleport_ziel_*")) do
		pos = v:GetPos()
		pos.z = pos.z - 16
		v:SetPos(pos)
	end
	
	for k,v in pairs(ents.FindByName("2knopftuercounte*")) do -- attempt to fix doors getting stuck by only requiring one button to be pressed
		v:SetKeyValue("max", "1")
	end
end