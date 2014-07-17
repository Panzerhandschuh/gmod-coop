HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "targetname" && v == "turret_15_coffre_munition_1") then
		e:Fire("AddOutput","OnPlayerUse !self,Addoutput,origin -3281.51 112.93 -756,0,-1", 0)
	end
end