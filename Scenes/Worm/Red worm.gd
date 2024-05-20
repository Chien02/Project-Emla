extends Worm

@export var spread : Skill
@export var shield : Skill

func _ready():
	set_target(get_tree().get_first_node_in_group("Flower"))
	shield.shield_on()
	health.init_health()
	anim_composition.moving() # move when spawned

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		if (!select_audio.playing):
			select_audio.play() # play audio
		health.decrease_health(100) # target damage
		shield.drop_shield()
