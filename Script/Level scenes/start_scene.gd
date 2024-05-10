extends Control

@export var start : bool = false
@export var text : Label
@export var string1 : String
@export var string2 : String

var flag : bool = false
var count_flag : int = 0

func _ready():
	start = Global.start_text
	text.text = string1

func _process(_delta):
	start = Global.start_text
	$".".visible = start
	handle_start()
	animation()

func animation():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(text, "scale", Vector2(2, 2), 1)

func handle_start():
	if start and !flag:
		flag = true
		$Timer.start()

func _on_timer_timeout():
	count_flag += 1
	$Text.scale = Vector2.ONE
	if count_flag == 2:
		start = false
		Global.start_text = false
		return
	text.text = string2
	
