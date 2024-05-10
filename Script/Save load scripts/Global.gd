extends Node

var score : int = 0
var high_score : int = 0
var level : int = 0
var tutorial : bool = false
var start_text : bool = false
var mystering : bool = false

var win : bool = false # use for main menu
var loss : bool = false

func _ready():
	tutorial = false
	loss = false
	win = false

func set_highscore(_amount):
	if (_amount > high_score):
		high_score = _amount
	return high_score
