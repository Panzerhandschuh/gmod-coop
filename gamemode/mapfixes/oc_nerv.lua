HOOKS["InitPostEntity"] = function()
	ents.FindByName("3imphap")[1]:Remove()
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnTrigger" || k == "OnStartTouch" || k == "OnPass" || k == "OnBreak" || k == "OnFullyOpen" || k == "OnIn") then
		if (v == "spawnpoint_1,Kill,,80,1" || string.match(v, "spawnpoint_%d,Kill,,60,1") || 
			string.find(v, "Quick_text,DisplayText,Respawn deactivated!")) then
			return "!activator,AddOutput,dummykey 0,0,-1"
		end
	elseif ((k == "OnOpen" && v == "spawnpoint_b,Kill,,60,1") || (k == "OnIn" && v == "spawnpoint_5a,Kill,,60,-1")) then
		return "!activator,AddOutput,dummykey 0,0,-1"
	elseif (e:GetClass() == "npc_combine_s" && k == "model" && v == "models/maps/nerv/jssdfsoldier.mdl") then
		return "models/combine_soldier.mdl"
	end
end