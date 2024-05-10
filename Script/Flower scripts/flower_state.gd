extends Node

class_name flower_state
@onready var animation = $"../AnimationPlayer"
func _ready():
	if (animation):
		animation.play("idle")

func _process(_delta):
	match Global.level:
		0: animation.play("idle")
		1: animation.play("idle_2")
		2: animation.play("idle_3")

func level_up1():
	animation.play("grow")

func level_up2():
	animation.play("grow_1")
