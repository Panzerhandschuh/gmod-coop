HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("prop_vehicle_airboat")) do
		v:SetSolid(SOLID_NONE)
		
		local s = ents.Create("vehicle_spawner")
		s:SetPos(v:GetPos())
		s:SetAngles(v:GetAngles())
		s.jmodel = v:GetModel()
		s.jscript = v.script
		s:Spawn()
		
		v:Remove()
	end

	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if(v:GetPos() == Vector(-2575.5, 6168.5, -1027)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,15,-1",0)
		end
	end
end