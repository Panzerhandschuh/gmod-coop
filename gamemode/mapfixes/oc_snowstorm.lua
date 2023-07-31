HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "npc_combine_s") then
		if (k == "additionalequipment") then
			if (v == "oc_snowstorm/custom_mp40") then
				return "weapon_smg1"
			elseif (v == "oc_snowstorm/custom_k98_npc") then
				return "weapon_ar2"
			end
		elseif (k == "model") then
			return "models/combine_soldier.mdl"
		end
	end

	if (e:GetClass() == "npc_zombie") then
		if (k == "model") then
			return ""
		end
	end
end

HOOKS["InitPostEntity"] = function()
	ents.FindByName("initblock")[1]:Remove()
	ents.FindByName("tankhealth")[1]:SetKeyValue("health", "1400")
	ents.FindByName("tankhealth2")[1]:SetKeyValue("health", "1400")

	for k,v in pairs(ents.FindByClass("prop_physics")) do
		if (string.find(v:GetModel(), "models/props_lab/binder")) then
			v:SetName("binder_" .. k)

			local sprite = ents.Create("env_sprite")
			sprite:SetName("binder_sprite_" .. k)
			sprite:SetPos(v:GetPos())
			sprite:SetKeyValue("model", "sprites/glow01.spr")
			sprite:SetKeyValue("rendermode", "9")
			sprite:SetKeyValue("rendercolor", "0 255 0")
			sprite:SetKeyValue("parent", "binder_" .. k)
			sprite:SetKeyValue("spawnflags", "1")
			sprite:Spawn()

			v:Fire("AddOutput","OnPlayerUse " .. "binder_sprite_" .. k .. ",Kill,,1,-1",0)
		end
	end
end

-- Adjust weapon loadout
HOOKS["PlayerSpawn"] = function(ply)
	timer.Simple( 0.1, function()
		ply:Give("weapon_ar2")
		ply:GiveAmmo(90, "ar2", true)
	end )
end