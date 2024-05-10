extends Node2D
# win scene

@export var cloud_anim : AnimationPlayer
@export var bg_anim : AnimationPlayer

@export var cloud1 : AnimatedSprite2D
@export var cloud2 : AnimatedSprite2D
@export var cloud3 : AnimatedSprite2D

@export var bg : AnimatedSprite2D

@export var dead_potision : Marker2D
@export var start_position : Marker2D

func _ready():
	cloud_anim.play("idle")
	bg_anim.play("idle")

func _process(_delta):
	moving_cloud(cloud1)
	moving_cloud(cloud2)
	moving_cloud(cloud3)
	animate_wish()

func moving_cloud(_cloud):
	#_cloud.position.x += 0.5
	if (_cloud.position.x > dead_potision.position.x):
		_cloud.position.x = start_position.position.x

func _on_timer_timeout():
	$CanvasLayer/Control/Vitory.visible = true
	fade_up($CanvasLayer/Control/Vitory)

func animate_wish():
	fade_up($CanvasLayer/Control/Wish)
	fade_up($CanvasLayer/Control/Wish2)

func fade_up(_object):
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(_object, "position", _object.position + Vector2(0, -0.1), 0.05)
	tween.tween_property(_object, "modulate", Color(1,1,1,1), 1)
