CreateConVar('coop_crowbar_dmg', 10, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE} )
CreateConVar('coop_stunstick_dmg', 40, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE} )

hook.Add("EntityTakeDamage", "CrowbarDmgMult", function(ent, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	if (attacker:IsPlayer()) then
		local weapon = attacker:GetActiveWeapon()
		if (attacker:IsPlayer() && weapon:IsValid() && dmgInfo:GetDamageType() == 128) then
			if (weapon:GetClass() == 'weapon_crowbar') then
				local crowbarDmg = GetConVar('coop_crowbar_dmg'):GetInt()
				dmgInfo:SetDamage(crowbarDmg)
			end
			
			if (weapon:GetClass() == 'weapon_stunstick') then
				local stunstickDmg = GetConVar('coop_stunstick_dmg'):GetInt()
				dmgInfo:SetDamage(stunstickDmg)
			end
		end
	end
end)