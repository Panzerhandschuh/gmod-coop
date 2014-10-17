if CLIENT then
    if not FStaminaToggled then
        function FStamina_Draw()
            if LocalPlayer():GetNWInt("FStamina") then
                if LocalPlayer():Alive() then
					local xPos = 576
					local yPos = ScrH() - 64
					local width = 256
					local height = 24
                    draw.RoundedBox(4, xPos, yPos, width, height, Color(128, 128, 128, 255))
                    if LocalPlayer():GetNWInt("FStamina") > 1 then
						local barColor
						local stamina = LocalPlayer():GetNWInt("FStamina" )
						if (stamina < 30) then
							barColor = Color(255, 0, 0, 255)
						else
							barColor = Color(255, 192, 0, 192)
						end
                        draw.RoundedBox(4, xPos, yPos, width * (stamina / 100), height, barColor)
                    end
                end
            end
        end
        hook.Add("HUDPaint", "FStamina_Draw", FStamina_Draw)
    end
end
 
if SERVER then
    if not FStaminaToggled then
        function FStamina_Spawn( ply )
            ply:SetNWInt("FStamina", 100)
        end
        hook.Add("PlayerSpawn", "FStamina_Spawn", FStamina_Spawn)
 
        function FStamina_MainThink()
            for k, ply in pairs(player.GetAll()) do
                if (ply:GetNWInt( "FStamina" ) < 0) then ply:SetNWInt( "FStamina", 0 ) end
                if (ply:GetNWInt( "FStamina" ) > 100) then ply:SetNWInt( "FStamina", 100 ) end
 
                if (ply:GetMoveType() ~= MOVETYPE_NOCLIP) then
					local isSprinting = ply:KeyDown(IN_SPEED) && !ply:Crouching() && ply:GetMoveType() != MOVETYPE_LADDER && (ply:KeyDown(IN_FORWARD) || ply:KeyDown(IN_BACK) || ply:KeyDown(IN_MOVELEFT) || ply:KeyDown(IN_MOVERIGHT))
					local stamina = ply:GetNWInt("FStamina")
                    if (isSprinting || ply:WaterLevel() == 3) then -- Sprinting or under water
						local speedReduction = 0
						if (isSprinting) then speedReduction = speedReduction + 0.35 end
						if (ply:WaterLevel() == 3) then speedReduction = speedReduction + 0.1 end
						if (stamina > 0) then
							ply:SetNWInt("FStamina", math.max(stamina - speedReduction, 0))
						end
                    else -- Not sprinting and not in water
                        ply:SetNWInt("FStamina", ply:GetNWInt("FStamina") + 0.35)
					end
 
					if (ply:GetNWInt("FStamina") <= 0) then -- Player can no longer sprint
						ply:SetRunSpeed(ply:GetWalkSpeed())
						--if (ply:WaterLevel() == 3) then -- Underwater damage
						--	ply:TakeDamage(0.1, nil, nul)
						--end
					else
						ply:SetRunSpeed(320)
					end
                end
            end
        end
        hook.Add("Think", "FStamina_MainThink", FStamina_MainThink)
    end
end
 
function FStamina_Toggle()
    if FStaminaToggled then
        FStaminaToggled = false
    else
        FStaminaToggled = true
    end
end
concommand.Add("stamina_toggle", FStamina_Toggle)