HOOKS["InitPostEntity"] = function()
	ents.FindByName("crane_mover")[1]:Remove()
	ents.FindByName("crane_hook")[1]:Remove()
	ents.FindByName("crane_bed")[1]:Remove()
	ents.FindByName("fence_door3")[1]:Remove()
	
	ents.FindByName("crane_rope_start_1")[1]:Remove()
	ents.FindByName("rope_crane_end")[1]:Remove()
	ents.FindByName("crane_rope_end_1")[1]:Remove()
	ents.FindByName("crane_rope_end_2")[1]:Remove()
	ents.FindByName("crane_rope_end_3")[1]:Remove()
	ents.FindByName("crane_rope_end_4")[1]:Remove()
	
	
	ents.FindByName("fence_door1")[1]:GetPhysicsObject():SetMass(500)
	ents.FindByName("fence_door2")[1]:GetPhysicsObject():SetMass(500)
	ents.FindByName("fence_door3")[1]:GetPhysicsObject():SetMass(500)
end