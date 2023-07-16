--cool map timer :D

if SERVER then
	TIMER = {} 
	
	function TIMER:Start()
		if (self.start) then
			return
		end

		self.start = CurTime()
		SetGlobalFloat("MapTimer_Start",self.start)
	end
	
	function TIMER:Finish()
		local f = CurTime()
		local start = tonumber(GetGlobalFloat("MapTimer_Start",CurTime()))
		local rt = string.FormattedTime(f-start)
		local time = string.format("%02i:%02i:%02i.%02i",rt.h,rt.m,rt.s,rt.ms)
		for _, ply in pairs(player.GetAll()) do
			if (ply.deaths) then
				ply:ChatPrint("[Coop] The map has been beaten in " .. time .. ", well done!")
				ply:ChatPrint("[Coop] You have died " .. ply.deaths .. " time(s).")
			end
		end
	end
	
	hook.Add("PlayerSay","TIMER_Say",function(sender, text, teamChat)
		local full = string.lower(text)
		local cmd = string.sub(full, 1, 6)
		if(cmd == "!timer" || cmd == "/timer") then
			sender:SendLua("TIMER_Toggle()")
			return ""
		end
	end)
else
	local showtimer = CreateClientConVar("cl_cooptimer_show", "1", true, false) --client cvars are persistent if u set that arg to true :D
	
	function TIMER_Toggle()
		local entext = nil
		if(showtimer:GetBool()) then
			entext = "disabled"
			LocalPlayer():ConCommand("cl_cooptimer_show 0")
		else
			entext = "enabled"
			LocalPlayer():ConCommand("cl_cooptimer_show 1")
		end
		chat.AddText(Color(255,255,255),'[',Color(21,40,132),'Coop',Color(255,255,255),'] The timer display has been '..entext..'!')
	end
	
	local function TIMER_Draw()
		if(!showtimer:GetBool()) then return end
		local f = CurTime()
		local start = tonumber(GetGlobalFloat("MapTimer_Start",CurTime()))
		local rt = string.FormattedTime(f-start)
		local tim = string.format("%02i:%02i:%02i",rt.h,rt.m,rt.s)
		
		surface.SetTextColor(255,192,0,160)
		surface.SetTextPos(ScrW()/2-(96/2),10)
		surface.SetFont("CloseCaption_Bold")
	
		surface.DrawText(tim)
	end
	
	hook.Add("HUDPaint","TIMER_Draw",TIMER_Draw)
end