-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")		

		ply:GiveAmmo(225, "smg1", true)
		ply:GiveAmmo(12, "buckshot", true)
		ply:GiveAmmo(30, "ar2", true)
	end )
end

HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetName() == "weaponbox_template" && k == "spawnflags") then
		return "3"
	--elseif (e:GetName() == "superstrider_template" || e:GetName() == "gunships_template") then -- Remove crash entities
	--	e:Remove()
	--elseif (e:GetName() == "sniper2" && k == "rendermode") then
	--	return "0"
	elseif (e:GetName() == "security_button_counter" && k == "OnHitMax" && string.match(v, "security_relay")) then
		return "!activator,AddOutput,dummykey 0,0,-1"
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("weaponbox_template")[1]:Remove()
	ents.FindByName("relay_combineshieldwall1_off")[1]:Remove()
	ents.FindByName("turret_1_model")[1]:Remove()
	ents.FindByName("clip_combineshieldwall1")[1]:Remove()
	ents.FindByName("brush_combineshieldwall1")[1]:Remove()
	ents.FindByName("clip_combineshieldwall2")[1]:Remove()
	ents.FindByName("brush_combineshieldwall2")[1]:Remove()
	ents.FindByName("ballspawner_ballgenerator1")[1]:Remove()
	
	local r1 = ents.Create("weapon_rpg")
	r1:SetPos(Vector(-95, -3364, -70))
	r1:SetAngles(Angle(0, 0, 0))
	r1.ei = 0.1
	r1.oPos = Vector(-95, -3364, -70)
	r1.oAng = Angle(0, 0, 0)
	r1:Spawn()

	local r2 = ents.Create("weapon_rpg")
	r2:SetPos(Vector(-95, -3364, -70))
	r2:SetAngles(Angle(0, 0, 0))
	r2.ei = 0.2
	r2.oPos = Vector(-95, -3364, -70)
	r2.oAng = Angle(0, 0, 0)
	r2:Spawn()
	
	-- Fix sniper crash
	--ents.FindByName("sniper2_kill_relay")[1]:Remove()
	--ents.FindByName("fakesniper2_model")[1]:Remove()
	
	-- Remove crash button (for some reason this button crashes even when it does nothing)
	-- for k,v in pairs(ents.FindByClass("func_button")) do
		-- if (v:GetPos() == Vector(-8003.5, 10216, 233.5)) then
			-- v:Remove()
		-- end
	-- end
	
	-- Fix crash (decrease math_counter value)
	--ents.FindByName("topside_defense_counter")[1]:SetKeyValue("max", "3")
	--ents.FindByName("security_button_counter")[1]:Remove()
	
	-- Set end game trigger
	-- local ge = ents.Create("game_end")
	-- ge:SetName("fakegameender")
	-- ge:Spawn()
	-- for k,v in pairs(ents.FindByClass("func_button")) do
		-- if (v:GetPos() == Vector(-8003.5, 10118, 233.5)) then
			-- -- for x,y in pairs(storage) do
				-- -- v:Fire("AddOutput", "OnPressed "..y, 0)
			-- -- end
			-- v:Fire("AddOutput", "OnPressed fakegameender,EndGame,,20,-1",0)
		-- end
	-- end
end