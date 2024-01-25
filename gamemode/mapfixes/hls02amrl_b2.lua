-- all done within the map now


--[[
-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
	timer.Simple( 0.1, function()
	ply:StripWeapons()
	
	end )
end



--[[
-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
    timer.Simple( 0.1, function()
	ply:StripWeapons()
	
	-- an attempt to modify your loadout after triggering certain checkpoints, doesn't seem to work
			--[[
        ply:StripWeapon("weapon_physcannon")
        ply:StripWeapon("weapon_crowbar")
        ply:StripWeapon("weapon_pistol")
        ply:StripWeapon("weapon_smg1")
        ply:StripWeapon("weapon_frag")

	print(ents.FindByName("coop_checkpoint3")[1].hasActivated)
		
    if (!ents.FindByName("coop_checkpoint3")[1].hasActivated) then
        ply:StripWeapon("weapon_crowbar")
    end 	]]--
	
--  end )
--end