local pl = FindMetaTable("Player")

function pl:GetAux()
	return self:GetDTFloat(47)
end

function pl:SetAux(num)
	self:SetDTFloat(47,num)
end

local restoreto = {}
local damagetime = {}
local restoretime = {}

local STAM = {}

function STAM.Move(ply,data)
	if(!ply || !ply.GetAux) then return end
	if(ply:Alive() && ply:GetMoveType() != MOVETYPE_NOCLIP) then
		local sprinter = data:KeyDown(IN_SPEED) && !ply:Crouching() && ply:GetMoveType() != MOVETYPE_LADDER && (data:GetForwardSpeed() != 0 || data:GetSideSpeed() != 0)
		local stam = ply:GetAux()
		if(stam > 0) then
			if(sprinter) then
				stam = math.max(stam-(23*FrameTime()),0)
			end
			if(ply:WaterLevel() == 3) then
				stam = math.max(stam-(5*FrameTime()),0)
			end
			if(stam != 0) then
				ply:SetRunSpeed(320)
			else
				ply:SetRunSpeed(ply:GetWalkSpeed())
				if(SERVER && ply:WaterLevel() == 3) then
					damagetime[ply] = CurTime() + 10
					restoreto[ply] = 0
				end
			end
		end
		if(!sprinter && ply:WaterLevel() != 3 && !data:KeyDown(IN_SPEED)) then
			stam = math.min(stam+(23*FrameTime()),100)
		end
		ply:SetAux(stam)
		if(SERVER) then
			if(stam <= 0 && damagetime[ply] && ply:WaterLevel() == 3) then
				if(damagetime[ply] <= CurTime()) then
					local dmginfo = DamageInfo()
					dmginfo:SetDamage(10)
					dmginfo:SetDamageType(DMG_DROWN)
					dmginfo:SetAttacker(game.GetWorld())
					dmginfo:SetInflictor(game.GetWorld())
					dmginfo:SetDamageForce(Vector(0,0,1))

					ply:TakeDamageInfo(dmginfo)
				
					damagetime[ply] = CurTime() + 1
					restoreto[ply] = restoreto[ply] + 1
					if(ply:Health() <= 10) then
						restoreto[ply] = 0 --they will die
					end
				end
				restoretime[ply] = nil
			elseif(restoreto[ply] && ply:WaterLevel() != 3) then
				if(!restoretime[ply]) then
					restoretime[ply] = CurTime()+2
				end
				if(restoretime[ply] <= CurTime() && restoreto[ply]>0) then
					ply:SetHealth(math.min(ply:Health()+10,100))
					
					restoretime[ply] = CurTime()+2
					restoreto[ply] = restoreto[ply] - 1
				end
			end
		end
	end
end

if SERVER then
	function STAM.PlayerInitialSpawn(ply)
		ply:SetAux(100)
	end
elseif CLIENT then
	local barnum = 8
	local alpha = 0

	function STAM.HUDPaint()
		if(!LocalPlayer || !LocalPlayer().GetAux) then return end
		local s = LocalPlayer():GetAux()
		if(!s) then return end
		local x = 576
		local y = ScrH() - 75
		
		local target = 160
		if(s >= 100) then
			target = 0
		end
		
		alpha = Lerp(4*FrameTime(), alpha, target)
	
		local col = Color(255, 192, 0, alpha)
		local col2 = Color(64, 48, 0, alpha)
		
		local curbar = math.ceil(s/12.5)
		local d = s-((curbar-1)*12.5)
		local cbaralpha = d/12.5 --fraction of 1
		
		local col3 = Color(col2.r+((col.r-col2.r)*cbaralpha),col2.g+((col.g-col2.g)*cbaralpha),col2.b+((col.b-col2.b)*cbaralpha),alpha)
		
		if(s == 0) then
			surface.SetDrawColor(col2)
		else
			surface.SetDrawColor(col)
		end
		
		for i=1,barnum do
			if i < curbar then --these happen first so we dont reset color
				surface.DrawRect(x+((i-1)*32),y,30,35)
			elseif i == curbar then --we modify color alpha before we use it
				surface.SetDrawColor(col3)
				
				surface.DrawRect(x+((i-1)*32),y,30,35)
				
				surface.SetDrawColor(col2)
			elseif i > curbar then
				surface.DrawRect(x+((i-1)*32),y,30,35)
			end
		end
		
		surface.SetDrawColor(Color(255,255,255,255))
	end
end

for k,v in pairs(STAM) do
	hook.Add(k,"STAM_"..k,v)
end