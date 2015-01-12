HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "t1" && k == "message") then
		return "Password: 9267"
	end
end