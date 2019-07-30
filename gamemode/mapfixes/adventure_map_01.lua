HOOKS["InitPostEntity"] = function()
	ents.FindByName("domek")[1]:Remove()

	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(11036, -1042, 379.79)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,5,-1",0)
		end
	end
end