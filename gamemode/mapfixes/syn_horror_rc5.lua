HOOKS["InitPostEntity"] = function()
	ents.FindByName("mpc_count")[1]:Fire("add", "2", 0)
	
	for k,v in pairs(ents.FindByClass("info_player_deathmatch")) do
		if(v:GetPos() == Vector(32, -192, -447)) then
			v:SetKeyValue("targetname", "cp1")
			break
		end
	end
	
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(1296, 304, -592)) then
			v:Fire("AddOutput","OnTrigger cp1,Disable,,0,-1",0)
			break
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnTrigger") then
		if (v == "a4_skill2_spawner,Enable,,105,-1") then
			return "a4_skill2_spawner,Enable,,50,-1"
		elseif (v == "a4_skill3_spawner,Enable,,240,-1") then
			return "a4_skill3_spawner,Enable,,100,-1"
		elseif (v == "a4_s_s,Enable,,320,-1") then
			return "a4_s_s,Enable,,150,-1"
		end
	end
end