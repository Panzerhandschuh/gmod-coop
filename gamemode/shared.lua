include("player_class/player_coop.lua")
include("rtv/config.lua")

GM.Name = "Coop"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("base") 
DEFINE_BASECLASS("gamemode_base")

function GM:ShouldCollide(ent1,ent2)
	if(ent1:IsPlayer() && ent2:IsPlayer()) then
		return false
	end
	
	return true
end