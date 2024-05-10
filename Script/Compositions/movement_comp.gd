extends Node2D

class_name Movement

# Called when the node enters the scene tree for the first time.
func movement(_delta, speed : int):
	if (owner.is_in_group("Worm")):
		if (!owner.target): return
		var direction = (owner.target.position - owner.position).normalized()
		owner.velocity = lerp(owner.velocity, direction * owner.info.speed, _delta) if (!owner.health.die) else Vector2.ZERO
		if owner.velocity.x < 0:
			owner.sprite.flip_h = true
		owner.move_and_slide()
#	else for boss
