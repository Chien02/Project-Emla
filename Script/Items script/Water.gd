extends AnimatedSprite2D

class_name Water

@export var anim_player : AnimationPlayer

func _ready():
	water_animation()

func _on_timer_timeout():
	queue_free()

func water_animation():
	if anim_player:
		anim_player.play("jump")

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		print("Mouse clicked")
		CustomCursorMouse.click()
		Global.gain_water()
		queue_free()
