extends Control

func _on_replay_button_down():
	get_tree().paused = false
	$".".visible = false
	get_tree().reload_current_scene()


func _on_menu_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
