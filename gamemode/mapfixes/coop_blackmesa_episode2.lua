-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")

		ply:GiveAmmo(90, "smg1", true)
		ply:GiveAmmo(12, "buckshot", true)
	end )
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("func_button")) do
		if (v:GetPos() == Vector(956.55, -247, -9)) then
			v:SetKeyValue("wait", "10")
		end
	end
	
	for k,v in pairs(ents.FindByName("lift")) do
		v:SetKeyValue("speed", "400")
	end
	
	local ge = ents.Create("game_end")
	ge:SetName("fakegameender")
	ge:Spawn()
	for k,v in pairs(ents.FindByClass("func_button")) do
		if(v:GetPos() == Vector(1628, 393.5, -3222)) then
			v:Fire("AddOutput","OnPressed fakegameender,EndGame,,5,1",0)
		end
	end
end