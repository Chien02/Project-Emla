extends Control

func _on_menu_button_down():
	$Select.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_restart_button_down():
	$Select.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")


func _on_visibility_changed():
	if visible:
		$Score.text = "Score: " + str(Global.score)
		$Highscore.text = "Highscore: " + str(Global.set_highscore(Global.score))
