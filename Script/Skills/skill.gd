extends Node2D

class_name Skill

@export var anim_name : String
@export var skill_damage : int

var anim_resource : SpriteFrames
var anim_sprite : AnimatedSprite2D
var anim_play : AnimationPlayer
var activing : bool

func active():
	visible = !visible
	pass

func get_skill_damage():
	return skill_damage
