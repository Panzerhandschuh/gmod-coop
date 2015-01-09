HOOKS["InitPostEntity"] = function()
	ents.FindByClass("point_viewcontrol")[1]:Remove()
	ents.FindByName("morbut")[1]:Remove()
	
	local board = ents.FindByName("board")[1]
	board:Fire("AddOutput","OnPlayerUse" "butf,Unlock,,0,1",0)
end