extends Area2D

class_name Tutorial

@export var tutorial : bool = true
@export var text : Label
@export var describe : String
@export var animation : AnimationPlayer
@export var text_animation : AnimationPlayer
@export var text_marker : Marker2D

func _ready():
	if Global.tutorial:
		text.position = text_marker.position
		text.text = describe
	else:
		off_tutorial()

func _process(_delta):
	to_tutorial()

func to_tutorial():
	if !Global.tutorial:
		off_tutorial()
		return
	text.position = text_marker.position
	text.text = describe
	$AnimatedSprite2D.visible = true
	animation.play("pointat")
	text_animation.play("wickle")

func off_tutorial():
	$".".visible = false

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		tutorial = false


func _on_area_entered(area):
	if area.is_in_group("Flower"):
		Global.tutorial = false
		Global.start_text = true
