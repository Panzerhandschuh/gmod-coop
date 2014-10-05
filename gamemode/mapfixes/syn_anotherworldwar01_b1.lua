HOOKS["InitPostEntity"] = function()
	RunConsoleCommand("sk_gunship_health_increments", "3")
	RunConsoleCommand("sk_plr_dmg_pistol", "10")
	RunConsoleCommand("sk_plr_dmg_smg1", "6")
	RunConsoleCommand("sk_plr_dmg_ar2", "10")

	for k,v in pairs(ents.FindByClass("npc_barney")) do
		v:SetHealth(9999999)
	end
	
	ents.FindByName("barn_ship_counter")[1]:Remove()
end