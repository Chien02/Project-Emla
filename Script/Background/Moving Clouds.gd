extends Node2D

var speed : int = 50
@export var start_marker : Marker2D
@export var end_marker : Marker2D

var clouds

func _ready():
	clouds = get_children()

func _process(delta):
	for cloud in clouds:
		cloud.position += Vector2.RIGHT * speed * delta
		if (end_marker and start_marker):
			if cloud.position >= end_marker.position:
				cloud.position = start_marker.position
