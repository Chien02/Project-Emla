extends Area2D

@export var card_sprite : Sprite2D
@export var card_bg_sprite : Sprite2D
@export var description : String
@export var cost : int
@export var cool_time : float
@export var can_buy : bool
@export var collected : bool

var last_position : Vector2 = Vector2.ZERO

signal be_bought

func drag():
	var mouse_pos = get_viewport().get_mouse_position()
	position = lerp(position, mouse_pos, 0.8)

func drop():
	position = lerp(position, last_position, 0.8)

func display():
	modulate = Color(1, 1, 1)

func undisplay():
	modulate = Color(0.145, 0.631, 1)

func cooldown():
	can_buy = false
	$Timer.wait_time = cool_time
	$Timer.start()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton :
		if event.pressed:
			drag()
		elif !event.pressed:
			drop()

func _on_timer_timeout():
	can_buy = true

func _on_area_entered(_area):
	if _area.is_in_group("Slot"):
		be_bought.emit()
