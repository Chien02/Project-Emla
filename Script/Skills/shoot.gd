extends Skill

@export var timer : Timer
@onready var can_shoot : bool = true
var target_pos : Vector2

func active():
	print("Can shoot: ", can_shoot)
	if !can_shoot: return
	# Play tween animation
	can_shoot = false
	shoot_animation()

func shoot_animation():
	var idx_of_anim_composition = 3
	var flower = get_tree().get_first_node_in_group("Flower")
	var amim_comp = flower.get_child(idx_of_anim_composition)
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(amim_comp, "scale", Vector2(1, 1.5), 0.2)
	tween.tween_property(amim_comp, "scale", Vector2(1.5, 1.5), 0.2)
	# Shoot sting in middle animation to "juice"
	shoot_sting()
	tween.tween_property(amim_comp, "scale", Vector2(1.5, 1), 0.2)
	tween.tween_property(amim_comp, "scale", Vector2(1, 1), 0.2)
	await tween.finished
	activing = !activing
	# Active timer to cooldown
	timer.start()

func _on_cooldown_timeout():
	can_shoot = true
	activing = !activing

func shoot_sting():
	var flower = get_tree().get_first_node_in_group("Flower")
	for idx in range(0, 2):
		var sting = preload("res://Scenes/Items/Sting/Sting.tscn").instantiate()
		sting.position = flower.position
		flower.add_child(sting)
		match idx: # Shoot both side left and right
			0: sting.set_target(flower.position + Vector2.RIGHT)
			1: sting.set_target(flower.position + Vector2.LEFT)

func set_target(_target: Vector2):
	self.target_pos = _target
