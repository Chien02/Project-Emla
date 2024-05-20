extends CanvasLayer
# transition
var next_scene

func trans_in(_next_scene):
	$AnimatedSprite2D.visible = true
	$AnimationPlayer.play("in")
	self.next_scene = _next_scene
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/loading_scene.tscn")
	$AnimatedSprite2D.visible = false
	

func trans_out(_next_scene):
	$AnimatedSprite2D.visible = true
	get_tree().change_scene_to_file(_next_scene)
	$AnimationPlayer.play("out")
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.visible = false

