HOOKS["InitPostEntity"] = function()
	RunConsoleCommand("sk_gunship_health_increments", "3")
	RunConsoleCommand("sk_plr_dmg_pistol", "10")
	RunConsoleCommand("sk_plr_dmg_smg1", "6")
	RunConsoleCommand("sk_plr_dmg_ar2", "10")
	
	ents.FindByName("barn_ship_counter")[1]:Remove()
end

HOOKS["EntityTakeDamage"] = function(e,dmg)
	if (e:GetClass() == "npc_barney" || e:GetClass() == "npc_citizen") then
		dmg:SetDamage(0)
	end
	
	return dmg
end