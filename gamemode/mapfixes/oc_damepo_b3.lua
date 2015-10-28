HOOKS["InitPostEntity"] = function()
	ents.FindByName("next_areadoor03")[1]:Remove()
	ents.FindByName("next_areadoor01")[1]:Remove()
	ents.FindByName("next_areadoor02")[1]:Remove()
	ents.FindByName("area3_killcounter01")[1]:Fire("add", "5")
end

HOOKS["EntityTakeDamage"] = function(e,dmg)
	if (e:GetName() == "last_Kleiner") then
		dmg:SetDamage(0)
	end
	
	return dmg
end