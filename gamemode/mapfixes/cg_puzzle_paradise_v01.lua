HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("counter_29-30")[1]
	counter:SetKeyValue("max", "24")
	counter.requiredPuzzles = 24 

	for k,v in pairs(ents.FindByName("counter_*")) do
		if (v:GetName() != "counter_29-30") then
			v:Fire("Add", "2", 0)
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.StartWith(k, "On") && e:GetPos() != Vector(2816, 11776, -12480) && e:GetPos() != Vector(-14848, -1896, -3776) && string.match(v, "counter_")) then
		e:Fire("AddOutput", k.." counter_29-30,Add,1,0,1", 0)
	end
end