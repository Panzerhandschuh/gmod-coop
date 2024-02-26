HOOKS["InitPostEntity"] = function()
	local coopTrigger = ents.FindByName("trial_a_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
	
	local tr = SYN_V.CreateTruck(Vector(2548, 423.68, -442.97),Angle(0, 270, 0),"scripts/vehicles/truck.txt")
	tr:SetName("trial_e_truck1") --the map requires this
end