extends Skill

@export var timer : Timer
@onready var can_generate_water : bool = true
@onready var flag_timer : bool = true

@onready var TIME_GENERATE_WATER_LVL_1 : float = 6
@onready var TIME_GENERATE_WATER_LVL_2 : float = 4
@onready var TIME_GENERATE_WATER_LVL_3 : float = 3.5

func active():
	activing = true
	rand_timer()

func _on_timer_timeout():
	if !can_generate_water: return
	can_generate_water = false
	generate_water()

func generate_water():
	# Do animation
	synthesis_animation()
	# Generate water
	var flower = get_tree().get_first_node_in_group("Flower")
	var water = preload("res://Scenes/Items/Water.tscn").instantiate()
	water.position = flower.position
	if (flower.get_parent()):
		flower.get_parent().add_child(water)

func synthesis_animation():
	var idx_animation_composition = 3
	var flower = get_tree().get_first_node_in_group("Flower")
	var flower_anim = flower.get_child(idx_animation_composition)
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(flower_anim, "scale", Vector2(1.5, 1), 0.1)
	tween.tween_property(flower_anim, "scale", Vector2(1.5, 1.5), 0.1)
	tween.tween_property(flower_anim, "scale", Vector2(1, 1.5), 0.1)
	tween.tween_property(flower_anim, "scale", Vector2(1, 1), 0.1)
	await tween.finished
	activing = !activing
	can_generate_water = true

func rand_timer():
	if !flag_timer: return
	flag_timer = true
	var time : float
	match(Global.level):
		0: time = TIME_GENERATE_WATER_LVL_1
		1: time = TIME_GENERATE_WATER_LVL_2
		2: time = TIME_GENERATE_WATER_LVL_3
	
	var rand_time = randf_range(3.5, time)
	if timer:
		timer.wait_time = rand_time
		timer.start()
