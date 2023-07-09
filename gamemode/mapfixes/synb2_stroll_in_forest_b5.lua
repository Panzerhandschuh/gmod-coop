HOOKS["EntityTakeDamage"] = function(target, dmginfo)
	if (dmginfo:GetInflictor():GetClass() == "env_laser") then
		dmginfo:ScaleDamage(0.25)
	end
end