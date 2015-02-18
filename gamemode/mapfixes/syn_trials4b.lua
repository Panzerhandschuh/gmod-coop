HOOKS["InitPostEntity"] = function()
	local ent = ents.FindByName("trial_b2_pretrigger")[1]
	ent:Fire("AddOutput","OnTrigger trial_b_trigger,Kill,,0,1",0)
	
	local coopTrigger = ents.FindByName("trial_d_hud")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
	coopTrigger = ents.FindByName("finale_coop")[1]
	coopTrigger:SetKeyValue("PlayerValue", "50")
	
	for k,v in pairs(ents.FindByName("trial_f_move*")) do
		if(v:GetPos().z == -144) then
			v:SetPos(v:GetPos()+Vector(0,0,4))
		end
		v:SetSaveValue("MoveDistance",28)
		v:SetKeyValue("movedistance",28)
	end
	
	for k,v in pairs(ents.FindByClass("trigger_physics_trap")) do
		if(v:GetPos().z == -144 && !IsValid(v:GetParent()) then
			v:SetPos(v:GetPos()+Vector(0,0,4))
		end
	end
end