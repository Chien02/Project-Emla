extends Worm

func be_bited():
	anim_composition.dead()
	var yellow_worm = preload("res://Scenes/Worm/Yellow worm.tscn").instantiate()
	yellow_worm.position = position
	yellow_worm.global_position = global_position
	await get_tree().create_timer(0.5).timeout
	owner.add_child(yellow_worm)
	queue_free()
