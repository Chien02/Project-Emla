extends Node2D

# spawn worms
@export var time_spwn_lvl1 : float = 2
@export var time_spwn_lvl2 : float = 1;
@export var time_spwn_lvl3 : float = 0.75;
@export var main_scene : Node2D

var can_spawn : bool = false

func _ready():
	$Timer.wait_time = time_spwn_lvl1
	$Timer.start()
	can_spawn = !Global.tutorial

func _process(_delta):
	can_spawn = !Global.tutorial if !Global.win else false
	match Global.level:
		0: $Timer.wait_time = time_spwn_lvl1
		1: $Timer.wait_time = time_spwn_lvl2
		2: $Timer.wait_time = time_spwn_lvl3
	destroy_when_win()

func spawn():
	var worm = preload("res://Scenes/worm.tscn").instantiate()
	worm.position = main_scene.get_rand_pos()
	worm.scale = Vector2.ONE * 1.65
	worm.main_scene = main_scene
	main_scene.add_child(worm)

func _on_timer_timeout():
	if (can_spawn):
		spawn()

func destroy_when_win():
	if Global.win:
		destroy_all()

func destroy_all():
	var worms = get_tree().get_nodes_in_group("Worm")
	for worm in worms:
		worm.die()
