extends Node2D


@export var time_spwn_lvl1 : float = 4
@export var time_spwn_lvl2 : float = 2
@export var time_spwn_lvl3 : float = 1.5
@export var max_x : float = 250
@export var max_y : float = 160
@export var main_scene : Node2D
@export var can_spawn : bool = false
@export var can_spawn_mys : bool = true

var time_spawn : float

func _ready():
	$Timer.wait_time = time_spwn_lvl1
	can_spawn = !Global.tutorial

func _process(_delta):
	can_spawn = !Global.tutorial if !Global.win else false
	match Global.level:
		0: time_spawn = time_spwn_lvl1
		1: time_spawn = time_spwn_lvl2
		2: time_spawn = time_spwn_lvl3
		3: time_spawn = time_spwn_lvl3
	$Timer.wait_time = time_spawn

func spawn():
	var rng = RandomNumberGenerator.new()
	var rnd_x = rng.randf_range(-max_x, max_x)
	var rnd_y = rng.randf_range(-max_y, max_y)
	var pos = Vector2(rnd_x, rnd_y)
	var new_energy = preload("res://Scenes/energy.tscn").instantiate()
	new_energy.position = pos
	new_energy.scale = Vector2(0.5, 0.5)
	if (main_scene):
		main_scene.add_child(new_energy)


func _on_timer_timeout():
	if (!can_spawn): return
	spawn()


func _on_timer_mysth_timeout():
	if (!can_spawn_mys): return
	var rng = RandomNumberGenerator.new()
	var rnd_x = rng.randf_range(-max_x, max_x)
	var rnd_y = rng.randf_range(-max_y, max_y)
	var pick_num = rng.randi_range(0, 7)
	
	if (pick_num == 5):
		var pos = Vector2(rnd_x, rnd_y)
		var new_mys = preload("res://Scenes/mysterial.tscn").instantiate()
		new_mys.position = pos
		if (main_scene):
			main_scene.add_child(new_mys)
