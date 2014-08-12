HOOKS["EntityKeyValue"] = function(e,k,v)
	if (e:GetClass() == "env_sprite" && k == "model" && v == "sprites/exit1.spr") then
		return "sprites/strider_blackball.spr"
	end
end