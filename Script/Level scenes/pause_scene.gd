extends Control

func _on_menu_button_down():
	$Close.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_continue_button_down():
	$Close.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	$".".visible = false


func _on_replay_button_down():
	$Close.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
	
