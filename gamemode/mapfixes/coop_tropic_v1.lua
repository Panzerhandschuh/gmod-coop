HOOKS["InitPostEntity"] = function()
	game.ConsoleCommand("sk_antlionguard_health 100\n")
	game.ConsoleCommand("sk_vortigaunt_dmg_zap 20\n")
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "logic_auto") then
		if (k == "OnMapSpawn" && v == "angry_insideguard*,AddOutput,health 2000,1,-1") then
			return "angry_insideguard*,AddOutput,health 1500,1,-1"
		elseif (k == "globalstate" && v == "global_coop_tropic_sknotset") then
			e:Remove()
		end
	end
end