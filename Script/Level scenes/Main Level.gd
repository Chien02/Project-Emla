extends Node2D

@export var pos_1 : Marker2D
@export var pos_2 : Marker2D
@export var pos_3 : Marker2D
@export var pos_4 : Marker2D
@export var mys : Node2D

@onready var loss_scene = $"CanvasLayer/Game Over"
@onready var flower_healthbar = $"Flower/Flower health"
@onready var paused_scene = $"CanvasLayer/Pause scene"

var energy_mng 
var score : int = 0
var flag_tutorial : bool = false
var flag_mys : bool = false

func _ready():
	Global.win = false
	loss_scene.visible = false
	score = 0

func _process(_delta):
	handle_mys()
	Global.score = score
	tutorial()

func add_score(value: int):
	score += value

func dec_score(value):
	score -= value
	if score <= 0:
		score = 0

func get_rand_pos():
	var rng = RandomNumberGenerator.new()
	var rand = rng.randi_range(0,4)
	match rand:
		0: return pos_1.position
		1: return pos_2.position
		2: return pos_3.position
		3: return pos_4.position
		_: return pos_1.position

func win():
	# Slow 2 seconds when win and change to win scene
	
	Engine.time_scale = 0.2
	await get_tree().create_timer(0.6).timeout
	# Return time_scale to normal and set Global.win variable to true to stop spawn object on scene
	Engine.time_scale = 1
	Global.win = true
	
	
	$Audio/Win.play()
	
	# After kill all worm then change to win scene
	await get_tree().create_timer(1.5).timeout # Wait for destroy all worms
	Transition.trans_in("res://Scenes/win_scene.tscn")
	
	#loss_scene.visible = false
	#flower_healthbar.visible = false
	#paused_scene.visible = false
	#get_tree().paused = true

func loss():
	Global.loss = true
	get_tree().paused = true
	$Audio/Loss.play()
	score = 0
	loss_scene.visible = true
	flower_healthbar.visible = false
	paused_scene.visible = false

func _on_pause_button_button_down():
	paused_scene.visible = true
	get_tree().paused = true
	$Audio/Open.play()

func tutorial():
	if Global.tutorial:
		$"Tutorial/Warning anim".visible = !flag_tutorial
		$"Tutorial/Tutorial player".play("warning")
		await get_tree().create_timer(2).timeout
		spawn_tutor_worm(flag_tutorial)

func spawn_tutor_worm(_flag_tutorial): 
	if (!_flag_tutorial):
		flag_tutorial = true
		var tutor_worm = preload("res://Scenes/tutorial_worm.tscn").instantiate()
		tutor_worm.position = $"Tutorial/Tutor worm marker".position
		$".".get_node("Tutorial").add_child(tutor_worm)
		tutor_worm.connect("tree_exited", spawn_tutor_energy)

func spawn_tutor_energy():
	if Global.tutorial:
		var tutor_e = preload("res://Scenes/tutorial_e.tscn").instantiate()
		tutor_e.position = $"Tutorial/Tutor energy marker".position
		$".".get_node("Tutorial").add_child(tutor_e)

func handle_mys():
	if Global.mystering and !flag_mys:
		print("Possible")
		flag_mys = true
		get_tree().paused = true
		mys.appear()
