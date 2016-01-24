HOOKS["InitPostEntity"] = function()
	game.ConsoleCommand("sk_antlionguard_health 100\n")
	game.ConsoleCommand("sk_vortigaunt_dmg_zap 20\n")
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "logic_auto" && k == "OnMapSpawn" && v == "angry_insideguard*,AddOutput,health 2000,1,-1") then
		return "angry_insideguard*,AddOutput,health 1500,1,-1"
	end
end