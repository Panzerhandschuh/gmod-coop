HOOKS["InitPostEntity"] = function()
	local trigger = ents.FindByName("trigger")[1]
	trigger:SetKeyValue("wait", "3")
	trigger:Fire("AddOutput","OnStartTouch strip,Strip,,0,-1",0)
	ents.FindByName("trigger2")[1]:SetKeyValue("wait", "3")

	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_once")) do
		if (v:GetPos() == Vector(3348, 196, 266)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,10,-1",0)
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (k == "OnStartTouch" && v == "trigger,Disable,,0,-1" || v == "trigger2,Disable,,0,-1") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end