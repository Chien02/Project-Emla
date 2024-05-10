extends Node2D

@export var marker : Marker2D
@export var reset_marker : Marker2D

func appear():
	$AnimationPlayer.play("idle")
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($".", "position", marker.position, 1)
	tween.parallel().tween_property($".", "modulate", Color(1, 1, 1, 1), 1)
	tween.tween_property($".", "position", marker.position-Vector2(2, 2), 0.2)
	await tween.finished
	roll()

func roll():
	$AnimationPlayer.play("roll")

func after_roll():
	$AnimationPlayer.play("finishedRoll")
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($".", "position", marker.position, 0.3)
	tween.tween_property($".", "position", marker.position - Vector2(0, 3), 0.3)
	await get_tree().create_timer(1).timeout
	finished()
	
func finished():
	Global.mystering = false
	get_tree().paused = false
	visible = false
	position = reset_marker.position
	modulate = Color(1,1,1,0)
