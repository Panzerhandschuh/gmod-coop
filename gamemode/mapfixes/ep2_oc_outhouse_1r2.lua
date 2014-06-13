HOOKS["EntityKeyValue"] = function(e,k,v)
	if(k == "OnPass" && v == "startcam_2,Enable,,0.5,1") then
		return "startcam_1,Disable,,0.5,1"
	end
end

HOOKS["OnEntityCreated"] = function(ent)
	if(ent:GetClass() == "item_custom") then --the ammo that spawns on the way back
		timer.Simple(0.1,function()
			if(ent:IsValid()) then
				if(!ent.ei) then
					ent.ei = ent:EntIndex()
					ent.oPos = ent:GetPos()
					ent.oAng = ent:GetAngles()
				end
			end
		end)
	end
end