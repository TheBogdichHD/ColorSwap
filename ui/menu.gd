extends Control

func _ready():
	if Save.data["settings"]["fullscreen"]:
		get_window().set_mode(Window.MODE_FULLSCREEN)


func Centre_Window():
	var Centre_Screen = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var Window_Size = get_window().get_size_with_decorations()
	get_window().set_position(Centre_Screen-Window_Size/2)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://ui/level_select.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://ui/settings_menu.tscn")


func _on_exit_pressed():
	Save.save_game()
	get_tree().quit()
