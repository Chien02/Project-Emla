extends Skill

@export var timer : Timer

@onready var can_shoot : bool = false
@onready var count_to_stop : int = 0

func _process(_delta):
	if count_to_stop == 3:
		count_to_stop += 1
		stop_shoot()
	elif count_to_stop < 3:
		shoot()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Flower"):
		timer.start()
		can_shoot = true
		owner.anim_composition.shoot()

func shoot():
	if !can_shoot: return
	count_to_stop += 1
	can_shoot = false
	if (owner.biting):
		owner.stop_bite()
	owner.anim_composition.shoot()
	# Stop moving
	owner.movement_composition.set_stop(true)
	
	# Get and add instance
	var flower = get_tree().get_first_node_in_group("Flower")
	var sting = preload("res://Scenes/Items/Sting/StingW.tscn").instantiate()
	sting.position = position
	sting.set_target(flower)
	add_child.call_deferred(sting)
	

func stop_shoot():
	timer.stop()
	owner.movement_composition.set_stop(false)
	if (owner.biting):
		owner.scontinue_bite()
	else:
		owner.anim_composition.moving()

func _on_timer_timeout():
	can_shoot = true
