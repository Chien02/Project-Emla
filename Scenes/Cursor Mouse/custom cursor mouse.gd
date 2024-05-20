extends AnimatedSprite2D

func _ready():
	play("idle")
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta):
	global_position = get_global_mouse_position()

func click():
	play("click")

func drag():
	play("drag")

func idle():
	play("idle")

func set_mouse_cursor():
	var cursor = preload("res://Sprites/Mouse cusor/mousecursor_icon.png")
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(32, 32))
