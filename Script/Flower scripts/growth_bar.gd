extends Control

var max_energy : int = 100
var current_energy : int = 0
var level : int = 1
var flower_health
signal win

func _ready():
	init_energy()

func _process(_delta):
	Global.level = level
	$Label.text = "Level: " + str(level + 1)
	$ProgressBar.value = current_energy
	if (current_energy == max_energy):
		level_up()

func init_energy():
	current_energy = 0
	$Label.text = "Level: " + str(level)

func increase(_amount):
	current_energy += _amount
	if (current_energy >= max_energy):
		current_energy = max_energy

func reduce(_amount):
	current_energy -= _amount
	if (current_energy <= 0):
		current_energy = 0

func level_up():
	animation()
	current_energy = 0
	level = (level + 1)
	if level >= 3:
		win.emit()
	max_energy += 30
	flower_health.increase(30)
	$LevelUp.play()
	$ProgressBar.max_value = max_energy

func animation():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property($ProgressBar, "scale", Vector2(1.5, 1.5), 0.5)
	tween.tween_property($ProgressBar, "scale", Vector2.ONE, 0.2)
	
	var flower = get_tree().get_first_node_in_group("Flower")
	flower.level_up(level)
