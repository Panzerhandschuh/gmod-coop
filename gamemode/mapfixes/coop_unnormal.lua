HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "trigger_multiple" && e:GetName() == "ldoor1") then
		if (k == "OnTrigger" && (v == "klaxon_all,PlaySound,,181,1" || string.find(v, "sec_door_trigger,Enable,,181,1"))) then
			return string.gsub(v, "181", "60")
		end
	end
end