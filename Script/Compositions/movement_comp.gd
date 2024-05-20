extends Node2D

class_name Movement_Composition

@onready var stop : bool = false

# Called when the node enters the scene tree for the first time.
func movement(_delta, speed : int):
	if (stop):
		owner.velocity = Vector2.ZERO
		return
	if (owner.is_in_group("Worm")):
		if (!owner.target):return
		var direction = (owner.target.position - owner.position).normalized()
		var new_velocity = lerp(owner.velocity, direction * owner.info.speed, _delta)
		owner.velocity = new_velocity if (!owner.health.die) else Vector2.ZERO
		owner.move_and_slide()
		flip_sprite(owner)
#	else for boss

func flip_sprite(_owner : CharacterBody2D):
	if owner.velocity.x < 0:
		owner.anim_composition.set_flip_h(true)

func set_stop(flag: bool):
	stop = flag
