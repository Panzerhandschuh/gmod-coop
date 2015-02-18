include("shared.lua")
include("rtv/cl_rtv.lua")

function GM:HUDPaintBackground()
	if(LocalPlayer && LocalPlayer():IsValid()) then
		local e = tonumber(LocalPlayer():GetNWInt("InCoopTrigger",0))
		if(e != 0) then
			local r = tonumber(GetGlobalInt(e.."_RequiredPlayers",1))
			local a = tonumber(GetGlobalInt(e.."_PlayerCount",1))
			
			local w,h = ScrW(),ScrH()
			draw.RoundedBox(8, (w/2)-150, h-175, 300, 50, Color(0,0,0,100))
			draw.SimpleText("Waiting for Players: "..a.."/"..r, "CloseCaption_Bold", w/2, h-150, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function DrawWaypointText()
	for k,v in pairs(ents.FindByClass("info_waypoint")) do
		if (v:GetPos():DistToSqr(LocalPlayer():GetPos()) >= 1000000) then
			continue
		end
	
		local angles = LocalPlayer():GetAngles()
		local position = v:GetPos();
		local message = v:GetNetworkedString("text")
		local offset = angles:Right() * -7;

		angles:RotateAroundAxis(angles:Forward(), 90);
		angles:RotateAroundAxis(angles:Right(), 90);
		angles:RotateAroundAxis(angles:Up(), 0);

		cam.Start3D2D(position + offset, angles, 0.1);
			draw.SimpleText(message, "CloseCaption_Normal", 80.5, 46, Color(255, 255, 255, 255), 1, 1);
		cam.End3D2D();
	end
end
hook.Add("PostDrawOpaqueRenderables", "DrawWaypointText", DrawWaypointText)

local c = Vector(-23.270752, -70.312988, 83.736328)

hook.Add("CalcView","SYN_V.CV",function (ply, origin, angles, fov, znear, zfar)
	local v = ply:GetVehicle()
	if(IsValid(v) && v:GetModel() == "models/vehicles/8seattruck.mdl") then
		local ang = v:GetAngles()
		local cor = c.x*ang:Forward()+c.y*ang:Right()+c.z*ang:Up()
		local view = {}
		view.origin 		= origin+cor
		view.angles			= angles
		view.fov 			= fov
		view.znear			= znear
		view.zfar			= zfar
		view.drawviewer		= false
		return GAMEMODE:CalcVehicleView( v, ply, view )
	end
end)