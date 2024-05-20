extends Skill

@export var hitbox : Area2D

func _on_area_2d_area_entered(area): # detect green worm
	if area.owner.is_in_group("Worm") and area.owner.info.worm_name == "Green worm":
		print("Catch Green worm")
		var worm = area.owner
		spread_yellow(worm)

func spread_yellow(worm):
	set_hitbox(false)
	worm.movement_composition.set_stop(true)
	owner.movement_composition.set_stop(true)
	owner.anim_composition.bite()
	worm.be_bited()
	await get_tree().create_timer(1).timeout
	owner.movement_composition.set_stop(false)
	owner.anim_composition.moving()

func _on_timer_timeout():
	set_hitbox(true)

func set_hitbox(flag: bool):
	hitbox.set_collision_mask_value(2, flag)
