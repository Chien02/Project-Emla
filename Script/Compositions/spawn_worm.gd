extends Node2D

# Time spawn worms
@export var time_spwn_lvl1 : float = 2
@export var time_spwn_lvl2 : float = 1
@export var time_spwn_lvl3 : float = 0.75

# Enable spawn worms
@export var enable_yellow_worm : bool
@export var enable_red_worm : bool

@export var left_marker : Marker2D
@export var right_marker : Marker2D
@export var disable : bool = false
var can_spawn : bool = false

func _ready():
	init_spawn()

func _process(_delta):
	if disable: return
	can_spawn = !Global.tutorial if !Global.win else false
	match Global.level:
		0: $Timer.wait_time = time_spwn_lvl1
		1: $Timer.wait_time = time_spwn_lvl2
		2: $Timer.wait_time = time_spwn_lvl3
	destroy_when_win()

func init_spawn():
	$Timer.wait_time = time_spwn_lvl1
	$Timer.start()
	$RandomTimer.wait_time = time_spwn_lvl1
	$RandomTimer.start()
	can_spawn = !Global.tutorial

func spawn(worm):
	# Choose side to spawn
	if (left_marker and right_marker):
		var rand_num = randi_range(1, 8)
		match rand_num:
			1, 2, 3, 4: worm.position = left_marker.position
			5, 6, 7, 8: worm.position = right_marker.position
	add_child(worm)

func spawn_green():
	var worm = preload("res://Scenes/Worm/Green worm.tscn").instantiate()
	spawn(worm)

func spawn_yellow():
	var worm = preload("res://Scenes/Worm/Yellow worm.tscn").instantiate()
	spawn(worm)

#func spawn_red():
	#var worm = preload("res://Scenes/Worm/Green worm.tscn").instantiate()
	#spawn(worm)

func _on_timer_timeout():
	if disable: return
	if (can_spawn):
		spawn_green()

func destroy_when_win():
	if Global.win:
		destroy_all()

func destroy_all():
	var worms = get_tree().get_nodes_in_group("Worm")
	for worm in worms:
		worm.die()

func _on_random_timer_timeout():
	var rand = randi_range(0, 15)
	match rand:
		0, 1, 2, 3, 4, 5:
			if enable_yellow_worm:
				spawn_yellow()
		#7, 8, 9:
			#if enable_red_worm:
				#spawn

func _on_enable_yellow_button_down():
	enable_yellow_worm = !enable_yellow_worm

func _on_enable_red_button_down():
	enable_red_worm = !enable_red_worm


