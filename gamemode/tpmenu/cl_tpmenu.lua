if SERVER then return end

surface.CreateFont( "VerdanaUI", {
	font = "Verdana",
	size = 25,
	weight = 500,
	antialias = true,
})

surface.CreateFont( "VerdanaUI_B", {
	font = "Verdana",
	size = 18,
	weight = 500,
	antialias = true,
})

TPMenu.Players = {}
TPMenu.TPPanel = nil
TPMenu.Keys = {}

local curpage = 1
local noinput = false

local menuEnabled = CreateClientConVar("cl_tpmenu_enabled", "1", true, false)

function TPMenu.CreatePanel()
	if (!menuEnabled) then return end

	if (!TPMenu.Players || #TPMenu.Players == 0) then return end
	
	if (TPMenu.TPPanel and TPMenu.TPPanel:IsVisible()) then
		TPMenu.TPPanel:Remove()
	end
	
	noinput = false
	curpage = 1
	
	local players = {}
	
	for k, v in pairs(TPMenu.Players) do
		if (k > 6) then break end
		table.insert(players, v)
	end

	TPMenu.Keys = {}
	TPMenu.TPPanel = vgui.Create( "DFrame" )
	local maxp = math.ceil(#TPMenu.Players / 6)
	
	local pn = TPMenu.TPPanel
	pn:SetSize( 300, 290 )
	pn:SetPos( 5, ScrH() * 0.4 )
	pn:SetTitle( "" )
	pn:ShowCloseButton(false)
	pn:SetDraggable(false)
	pn.Paint = function( self, w, h )
		surface.SetDrawColor(Color(28, 32, 40))
		surface.DrawRect( 0, 0, w, 30 )
		
		surface.SetDrawColor(Color(32, 37, 46))
		surface.DrawRect( 0, 30, w, h - 30 )

		draw.SimpleText("Teleport to...", "VerdanaUI", w/2,15,Color(236,240,241,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local exit = vgui.Create( "DLabel", pn )
		exit:SetFont( "VerdanaUI_B" )
		exit:SetColor( Color( 255, 255, 255, 255 ) )
		exit:SetText( "1) Exit" )
		exit:SetPos( 5, (26 * 1.5) )
		exit:SizeToContents()

	for k, v in ipairs( players ) do

		local text = vgui.Create( "DLabel", pn )
		text:SetFont( "VerdanaUI_B" )
		text:SetColor( Color( 255, 255, 255, 255 ) )
		text:SetText( tostring(k+1)..") " .. v["name"] )
		text:SetPos( 5, 60+(26 * k-1) )
		text:SizeToContents()

		TPMenu.Keys[k+1] = { text, v }

	end
	
	local prev = vgui.Create( "DLabel", pn )
		prev:SetFont( "VerdanaUI_B" )
		prev:SetColor( Color( 255, 255, 255, 255 ) )
		prev:SetText( "8) Previous" )
		prev:SetPos( 5, (26 * 9) )
		prev:SizeToContents()
		prev:SetVisible(false)
		
	local next = vgui.Create( "DLabel", pn )
		next:SetFont( "VerdanaUI_B" )
		next:SetColor( Color( 255, 255, 255, 255 ) )
		next:SetText( "9) Next" )
		next:SetPos( 5, (26 * 10) )
		next:SizeToContents()

	-- timer.Simple(15,function()
	-- 	if (TPMenu.TPPanel and TPMenu.TPPanel:IsVisible()) then
	-- 		TPMenu.TPPanel:Remove()
	-- 	end
	-- 	noinput = false
	-- end)

	pn.Think = function( self )

		if not noinput and input.IsKeyDown(KEY_8) and curpage > 1 then -- Previous page
			noinput = true
			curpage = curpage - 1
			for k,v in pairs(TPMenu.Keys) do
				local m = TPMenu.Players[((curpage-1)*6)+(k-1)]
				v[1]:SetText( tostring(k)..") " .. m["name"] )
				v[1]:SizeToContents()
				TPMenu.Keys[k] = { v[1], m }
			end
			next:SetVisible(true)
			if(curpage == 1) then
				prev:SetVisible(false)
			end
			timer.Simple(.2,function() noinput = false end)
		elseif not noinput and input.IsKeyDown(KEY_9) and curpage < maxp then -- Next page
			noinput = true
			curpage = curpage + 1
			for k,v in pairs(TPMenu.Keys) do
				local m = TPMenu.Players[((curpage-1)*6)+(k-1)]
				if (!m) then
					TPMenu.Keys[k] = { v[1] }
					v[1]:SetText( "" )
					v[1]:SizeToContents()
				else
					v[1]:SetText( tostring(k)..") " .. m["name"] )
					v[1]:SizeToContents()
					TPMenu.Keys[k] = { v[1], m }
				end
			end
			prev:SetVisible(true)
			if(curpage == maxp) then
				next:SetVisible(false)
			end
			timer.Simple(.2,function() noinput = false end)
		elseif not noinput and input.IsKeyDown(KEY_1) then -- Close menu
			if (TPMenu.TPPanel and TPMenu.TPPanel:IsVisible()) then
				TPMenu.TPPanel:Remove()
			end
			noinput = false

			chat.AddText( "Type !tpmenu to re-open the menu." )
		elseif not noinput and #TPMenu.Keys > 0 then -- Teleport to player

			for k, v in pairs( TPMenu.Keys ) do

				if input.IsKeyDown( k + 1 ) and v[1] and v[2] then

					noinput = true
					
					net.Start( "TPMenuTele" )
					net.WriteString(v[2]["steamid"])
					net.SendToServer()

					timer.Simple(.5, function() noinput = false end)

				end

			end

		end

	end

end

net.Receive( "TPMenuOpen", function()
	TPMenu.Players = net.ReadTable()
	TPMenu.CreatePanel()
end )

net.Receive( "TPMenuSuccess", function()
	if (TPMenu.TPPanel and TPMenu.TPPanel:IsVisible()) then
		TPMenu.TPPanel:Remove()
	end
end )
