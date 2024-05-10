extends Camera2D

# Main camera
@export var marker : Marker2D

func _ready():
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property($".", "position", marker.position, 0.5)


func _process(_delta):
	var tutor_worm = get_tree().get_first_node_in_group("Tutorworm")
	focus(tutor_worm)

func focus(_tutor_worm):
	if (_tutor_worm):
		var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT_IN)
		tween.tween_property($".", "position", _tutor_worm.position, 3)
	else:
		var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT_IN)
		tween.tween_property($".", "position", marker.position, 1)
