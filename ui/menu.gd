extends Control

func _on_play_pressed():
	SceneTransition.change_scene("res://levels/level1.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://ui/settings_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
