HOOKS["InitPostEntity"] = function()
	ents.FindByName("controllroom_door2_playerclip")[1]:Remove()
	ents.FindByName("controllroom_door2")[1]:Remove()
end