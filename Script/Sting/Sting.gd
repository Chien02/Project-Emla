extends AnimatedSprite2D

class_name Sting

const DAMAGE : int = 50
const SPEED : int = 500
var target : Vector2
var direction

func _ready():
	play("idle")

func set_target(_target: Vector2):
	self.target = _target

func _on_timer_timeout():
	queue_free()

func _on_area_2d_area_entered(area):
	if (area.is_in_group("Worm")):
		var worm = area.owner
		if worm.health.has_method("decrease_health"):
			worm.health.decrease_health(DAMAGE)
		queue_free()
