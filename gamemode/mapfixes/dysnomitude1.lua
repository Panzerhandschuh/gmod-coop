-- Adjust weapon loadout
HOOKS["PlayerLoadout"] = function(ply)
	timer.Simple( 0.1, function()
	ply:StripWeapons()
	end )
end

HOOKS["InitPostEntity"] = function()
	ents.FindByModel("models/props_c17/oildrum001_explosive.mdl")[1]:Fire("AddOutput","OnBreak to_ceilingwindowtrigger,Enable,,0,-1",0)
	ents.FindByName("to_ceilingwindowtrigger")[1]:Fire("AddOutput","OnStartTouch fb_dunnowhattonamethis,Kill,,0,-1",0)
	ents.FindByName("relay_combineshieldwall&i_on")[1]:SetKeyValue("StartDisabled", "1")
	ents.FindByName("fd_metaldoor3")[1]:Fire("AddOutput","OnClose cp1,SetAsCP,,0,1",0)
	
	local cp1 = ents.Create("coop_checkpoint")
	cp1:SetKeyValue("targetname", "cp1")
	cp1:SetKeyValue("updatecp", "1")
	cp1:SetKeyValue("radius", "0")
	cp1:SetKeyValue("moveplayers", "1")
	cp1:SetKeyValue("Angles", "0 0 0")
	cp1:SetKeyValue("Origin", "215 -1329 -119")
    cp1:Spawn()
	
end