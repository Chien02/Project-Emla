extends CharacterBody2D
# worm
class_name Worm

@export var info : W_description
@export var health : Health
@export var movement : Movement
@export var skill : String
@export var sprite : AnimatedSprite2D
@export var animation : AnimationPlayer
@export var fx_animation : AnimationPlayer

var target
var main_scene

func _ready():
	health.init_health()
	$EffectAnimation.visible = false
	set_target()
	animation.play("walk")
	

func _process(delta):
	movement.movement(delta, info.speed)
	if !health.is_connected("dead", die):
		health.connect("dead", die)

func fx():
	$Explode.play()  # play audio
	$EffectAnimation.visible = true
	fx_animation.play("default")

func die():
	process_mode = Node.PROCESS_MODE_ALWAYS
	animation.play("dead")


# Collide with player touch or cursor's click
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		if (main_scene):
			main_scene.add_score(1)
		if (!$Select.playing):
			$Select.play() # play audio
		health.decrease_health(100) # target damage

func set_target():
	target = get_tree().get_first_node_in_group("Flower")

