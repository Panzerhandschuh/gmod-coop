include("player_class/player_coop.lua")
include("rtv/config.lua")

GM.Name = "Coop"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("base") 
DEFINE_BASECLASS("gamemode_base")

local REPLACE_ENTS = {}
REPLACE_ENTS["npc_gargantua"] = "npc_antlionguard"
REPLACE_ENTS["npc_alien_grunt"] = "npc_combine_s"
REPLACE_ENTS["npc_hassassin"] = "npc_combine_s"

for k,_ in pairs(REPLACE_ENTS) do
	scripted_ents.Register({Type="ai", Base="base_ai"}, k, false)
end

function GM:ShouldCollide(ent1,ent2)
	if(ent1:IsPlayer() && ent2:IsPlayer()) then
		return false
	end
	
	return true
end