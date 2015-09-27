HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("filter_activator_team")) do
		v:Remove()
	end
	
	for k,v in pairs(ents.FindByName("teleport_ziel_*")) do
		pos = v:GetPos()
		pos.z = pos.z - 16
		v:SetPos(pos)
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.find(e:GetName(), "2knopftuercounte")) then
		if (k == "OnHitMax") then
			e:Fire("AddOutput","OutValue "..v, 0)
			return "!activator,AddOutput,dummykey 0,0,-1"
		end
	end
end