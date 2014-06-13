HOOKS["EntityKeyValue"] = function(e,k,v)
	if(e:EntIndex() == 273 && k == "spawnflags") then
		return "1024"
	end
	if(e:EntIndex() == 275 && k == "spawnflags") then
		return "1024"
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("game_player_equip")) do
		v:Remove()
	end
end