extends Control

@export var main_scene : Node2D
@export var score_label : Label
@export var growth_bar : Control
@export var flower_health : Control
@export var paused_scene : Control

func _ready():
	if (main_scene):
		main_scene.energy_mng = growth_bar
	if (flower_health):
		growth_bar.flower_health = flower_health
	score_label.text = "Score: 0"
	$Highscore.text = "Highcore: 0"

func _process(_delta):
	score_label.text = "Score: " + str(main_scene.score)
	$Highscore.text = "Highscore: " + str(Global.high_score)

func _on_growth_bar_win():
	main_scene.win()


func _on_flower_health_loss():
	main_scene.loss()

