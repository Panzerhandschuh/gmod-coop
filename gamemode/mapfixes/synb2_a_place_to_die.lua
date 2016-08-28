HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "l30" && k == "startburrowed") then
		return "0"
	end
end