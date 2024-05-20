extends AnimatedSprite2D

@export var timer : Timer

var target
@export var speed : int = 200
@export var damage : int = 35

func _ready():
	play("default")

func _physics_process(delta):
	global_position = global_position.move_toward(target.global_position, speed * delta)
	look_at(target.position)

func set_target(_target):
	target = _target

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()

func _on_timer_timeout():
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Flower"):
		area.health.decrease_health(damage)
		area.becrunch_audio.play()
		queue_free()
