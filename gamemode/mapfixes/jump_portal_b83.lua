include("../utils.lua")

HOOKS["InitPostEntity"] = function()
	CreateGameEnd()
	counter = CreatePuzzleCounter(9)
	counter:Fire("AddOutput","OnHitMax coop_game_end,EndGame,,10,-1",0)
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (string.StartWith(k, "OnStartTouch") && string.StartWith(v, "case_changedoors,InValue")) then
		e:Fire("AddOutput", k.." coop_puzzle_counter,Add,1,0,1", 0)
	end
end