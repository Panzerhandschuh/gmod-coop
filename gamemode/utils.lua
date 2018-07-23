function CreatePuzzleCounter(count)
	local counter = ents.Create("math_counter")
	counter:SetPos(Vector(0, 0, 0))
	counter:SetAngles(Angle(0, 0, 0))
	counter:SetName("coop_puzzle_counter")
	counter:SetKeyValue("StartDisabled", "0")
	counter:SetKeyValue("startvalue", "0")
	counter:SetKeyValue("min", "0")
	counter:SetKeyValue("max", count)
	counter.requiredPuzzles = count
	counter:Spawn()

	return counter
end

function CreateGameEnd()
	local ge = ents.Create("game_end")
	ge:SetName("coop_game_end")
	ge:Spawn()

	return ge;
end