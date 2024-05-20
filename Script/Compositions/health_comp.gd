extends Node2D

class_name Health_Composition

@export var max_health : int
@export var current_health : int
@export var die : bool = false

signal dead

func init_health():
	current_health = max_health
	die = false

func increase_health(amount: int):
	current_health += amount
	if current_health > max_health:
		current_health = max_health

func decrease_health(amount: int):
	current_health -= amount
	if current_health < 0:
		current_health = 0
		die = true
		dead.emit()
