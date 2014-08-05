-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:GiveAmmo(225, "smg1", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "func_breakable") then
		if (k == "health" && v == "1200") then
			return "500"
		end
	end
end

HOOKS["InitPostEntity"] = function()
	for k,v in pairs(ents.FindByClass("func_breakable")) do
		if(v:GetPos() == Vector(1007, 544, -123)) then
			v:Remove()
		end
	end
end