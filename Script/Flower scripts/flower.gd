extends Area2D

@export var health : Control
@export var main_scene  : Node2D

func _on_area_entered(area):
	if (area.get_parent().is_in_group("Worm")):
		health.decrease(area.get_parent().info.damage)
		$BeCrunched.play()
		await get_tree().create_timer(0.15).timeout
		if (!area): return # avoid error
		area.get_parent().queue_free()
	elif (area.is_in_group("Energy")):
		main_scene.energy_mng.increase(area.get_parent().e_value)
		absorb()
		area.get_parent().be_absorb()
		await get_tree().create_timer(0.5).timeout
		if (!area): return # avoid error
		area.get_parent().dead()

func absorb():
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "scale", Vector2(2.5, 2.5), 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(2, 2), 0.2).set_ease(Tween.EASE_IN)

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")

func level_up(_level: int):
	match _level:
		1: $State.level_up1()
		2: $State.level_up2()
