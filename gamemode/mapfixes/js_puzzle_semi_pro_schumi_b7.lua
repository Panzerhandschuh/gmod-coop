HOOKS["InitPostEntity"] = function()
	local counter = ents.FindByName("count_final")[1]
	counter.requiredPuzzles = 5
	counter:SetKeyValue("max", "5")
end

index = 0
HOOKS["EntityKeyValue"] = function(e,k,v)
	if (!e.ei && string.StartWith(e:GetName(), "rpg_")) then
		if (e:GetName() == "rpg_1") then
			e.ei = 0.1
		elseif (e:GetName() == "rpg_2") then
			e.ei = 0.2
		elseif (e:GetName() == "rpg_3") then
			e.ei = 0.3
		elseif (e:GetName() == "rpg_4") then
			e.ei = 0.4
		end
		e.oPos = e:GetPos()
		e.oAng = e:GetAngles()
	end
end