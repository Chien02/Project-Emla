extends Node2D


func _ready():
	$AnimatedSprite2D.visible = true
	$AnimationPlayer.play("loading")


func _on_animation_player_animation_finished(_anim_name):
	$AnimatedSprite2D.visible = false
	var next_scene = Transition.next_scene
	Transition.trans_out(next_scene)
