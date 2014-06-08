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