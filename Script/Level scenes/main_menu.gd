extends Node2D

@export var cloud1 : AnimatedSprite2D
@export var cloud2 : AnimatedSprite2D
@export var cloud3 : AnimatedSprite2D
@export var death_way : int
@export var start_way : int

func _ready():
	$"BackgroundAnim".play("default")
	$"TitleAnim".play("TitleEnter")
	$"Main Menu/Control/Highscore".text = "Highscore: " + str(Global.high_score)

func _process(_delta):
	$"BackgroundAnim".play("default")
	flower_anim()
	moving_cloud($Cloud)
	moving_cloud($Cloud2)
	moving_cloud($Cloud3)
	title_appear()

func title_appear():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property($"Main Menu/Control/Play button", "modulate", Color(1,1,1,1), 3)
	tween.parallel().tween_property($"Main Menu/Control/Highscore", "modulate", Color(1,1,1,1), 3)
	tween.parallel().tween_property($"Main Menu/Control/Play button", "position", $"Main Menu/Control/ButtonMarker".position, 3)
#
func _on_play_button_button_down():
	$select.play()
	Transition.trans_in("res://Scenes/main_level.tscn")


func _on_title_anim_animation_finished(anim_name):
	if (anim_name == "TitleEnter"):
		$TitleAnim.play("TitleLoop")

func moving_cloud(_cloud):
	if _cloud.position.x >= death_way:
		_cloud.position.x = start_way

func flower_anim():
	if Global.win:
		$Flower/FlowerAnim.play("idle2")
	else:
		$Flower/FlowerAnim.play("idle")
