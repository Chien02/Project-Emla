extends Control

@export var score_label : Label
@export var highscore_label : Label
var score = 0

func _process(_delta):
	score_label.text = "Score: " + str(score)
	highscore_label.text = "Highscore: " + str(Global.high_score)

func add_score(amount : int):
	score += amount
