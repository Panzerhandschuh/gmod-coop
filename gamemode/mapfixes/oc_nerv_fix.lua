HOOKS["InitPostEntity"] = function()
	ents.FindByName("3imphap")[1]:Remove()
	ents.FindByName("live")[1]:Remove()
	for k,v in pairs(ents.FindByName("clip")) do
		v:Remove()
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnTrigger" || k == "OnStartTouch" || k == "OnPass" || k == "OnBreak" || k == "OnFullyOpen" || k == "OnIn") then
		if (v == "spawnpoint_1,Kill,,80,1" || string.match(v, "spawnpoint_%d,Kill") || 
			string.find(v, "Quick_text,DisplayText,Respawn deactivated!")) then
			return "!activator,AddOutput,dummykey 0,0,-1"
		end
	elseif ((k == "OnOpen" && v == "spawnpoint_b,Kill,,60,1") || (k == "OnIn" && v == "spawnpoint_5a,Kill,,60,-1")) then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end