extends Control

# Flower health
@export var marker : Marker2D

var max_health : int = 100
var current_health : int = 100

signal loss

func _ready():
	init_health()

func _process(_delta):
	$ProgressBar.value = current_health

func init_health():
	current_health = max_health
	$ProgressBar.value = current_health

func increase(value):
	current_health += value
	if (current_health >= max_health):
		current_health = max_health

func decrease(value):
	current_health -= value
	if (current_health <= 0):
		loss.emit()
