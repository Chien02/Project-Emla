extends Node2D

class_name Level_Composition

const INIT_LEVEL : int = 1
const INIT_EXP : int = 100

@export var max_level : int
@export var current_level : int
@export var max_exp : int
@export var current_exp : int

@warning_ignore("integer_division")
@onready var add_exp = max_exp * (int)(20 / 100)

signal just_level_up

func init_level():
	current_exp = 0
	current_level = 0
	max_exp = INIT_EXP
	max_level = INIT_LEVEL

func reset_level():
	current_exp = 0
	current_level = 0

func level_up():
	current_level += 1
	current_exp = 0
	max_exp += add_exp
	update_add_exp()
	just_level_up.emit()

func gain_exp(amount : int):
	current_exp += amount
	if (current_exp >= max_exp):
		level_up()

func update_add_exp():
	@warning_ignore("integer_division")
	add_exp = max_exp * (int)(20 / 100)
