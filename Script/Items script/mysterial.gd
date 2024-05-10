extends Area2D

var hold : bool = false

func _ready():
	$AnimationPlayer.play("default")
	$Absorb.play()

func _process(_delta):
	drag()

func _on_area_entered(area):
	if (area.is_in_group("Flower")):
		print("Yes")
		Global.mystering = true
		$Absorb.play() # play audio
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		hold = true
	elif (event is InputEventMouseButton and !event.pressed):
		hold = false

func drag():
	if (!hold):
		$Timer.paused = false
		return
	$Hold.play() # play audio
	$Hold.autoplay = true
	$Timer.paused = true
	var mouse_pos = get_global_mouse_position()
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property($".", "global_position", mouse_pos, 0.1)
	await tween.finished

func _on_timer_timeout():
	queue_free()
