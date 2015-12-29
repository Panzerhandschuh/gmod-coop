include("player_class/player_coop.lua")
include("rtv/config.lua")
include("newstam.lua")
include("timer.lua")

GM.Name = "Coop"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("base") 
DEFINE_BASECLASS("gamemode_base")

local REPLACE_ENTS = {}
REPLACE_ENTS["npc_gargantua"] = "monster_gargantua"
REPLACE_ENTS["npc_alien_grunt"] = "monster_alien_grunt"
REPLACE_ENTS["npc_hassassin"] = "monster_human_assassin"
REPLACE_ENTS["npc_houndeye"] = "npc_headcrab"
REPLACE_ENTS["npc_bullsquid"] = "monster_bullchicken"
REPLACE_ENTS["npc_hgrunt"] = "npc_combine_s"
REPLACE_ENTS["npc_defender"] = "npc_hunter"
REPLACE_ENTS["monster_bigmomma"] = "npc_antlionguard"

for k,_ in pairs(REPLACE_ENTS) do
	scripted_ents.Register({Type="ai", Base="base_ai"}, k)
end

function GM:ShouldCollide(ent1,ent2)
	if (ent1:IsValid() && ent2:IsValid()) then
		if (ent1:IsPlayer() && ent2:IsPlayer()) then
			return false
		end
	end
	
	return true
end

if(file.Exists("coop/gamemode/mapfixes/"..game.GetMap()..".lua","LUA")) then
	HOOKS = {}
	include("coop/gamemode/mapfixes/"..game.GetMap()..".lua")
	for k,v in pairs(HOOKS) do
		hook.Add(k,k.."_"..game.GetMap(),v)
	end
end