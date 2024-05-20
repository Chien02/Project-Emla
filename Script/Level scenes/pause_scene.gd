extends Control

func _on_menu_button_down():
	$Close.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Level scenes/main_menu.tscn")

func _on_continue_button_down():
	$Close.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	change_visible()

func _on_replay_button_down():
	$Close.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_pause_button_down():
	get_tree().paused = !get_tree().paused
	change_visible()

func change_visible():
	var children = get_children()
	for child in children:
		if child.name != "Pause":
			child.visible = !child.visible
