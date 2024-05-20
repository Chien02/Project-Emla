extends Node2D

@export var e_value : int = 10
var hold : bool

func _ready():
	$AnimationPlayer.play("idle")

func _process(_delta):
	drag()

func play_animation():
	$AnimationPlayer.play("idle")

func _on_timer_timeout():
	if (name == "TutorialEnergy"): return
	queue_free()

func drag():
	if (!hold):
		$Timer.paused = false
		return
	$Hold.play() # play audio
	$Timer.paused = true
	var mouse_pos = get_global_mouse_position()
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property($".", "global_position", mouse_pos, 0.1)
	await tween.finished

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		hold = true
		CustomCursorMouse.drag()
	elif (event is InputEventMouseButton and !event.pressed) or (event is InputEventScreenTouch and !event.pressed):
		hold = false
		CustomCursorMouse.idle()

func be_absorb():
	$Absorded.play() # play audio
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	await $Absorded.finished


