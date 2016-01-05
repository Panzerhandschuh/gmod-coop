HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("info_player_start")) do
		v:Remove()
	end
	
	ents.FindByName("rebel_rebel_filter")[1]:Remove()
	for k,v in pairs(ents.FindByClass("filter_activator_team")) do
		v:Remove()
	end
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("trigger_multiple")) do
		if (v:GetPos() == Vector(9664.01, -704.01, -360)) then
			v:Fire("AddOutput","OnStartTouch fakegameender,EndGame,,15,-1",0)
		end
	end
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if ((string.find(e:GetName(), "wegsperre4*") || e:GetName() == "wegsperre3") && k == "OnDamaged") then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end