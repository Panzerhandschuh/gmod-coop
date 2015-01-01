HOOKS["InitPostEntity"] = function()
	ents.FindByName("mpc_count")[1]:Fire("add", "2", 0)
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