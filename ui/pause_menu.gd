extends CanvasLayer

@onready var label = $MarginContainer/VBoxContainer/Label
@onready var sound = preload("res://assets/sounds/button_ui.wav")

func _ready():
	if get_tree().get_current_scene().get_name() == "Level*":
		label.text = "Level."
	else:
		label.text = get_tree().get_current_scene().get_name()

func _on_resume_pressed():
	AudioPlayer.play_sound(sound)
	get_tree().paused = false
	hide()


func _on_main_menu_pressed():
	AudioPlayer.play_sound(sound)
	get_tree().change_scene_to_file("res://ui/menu.tscn")
	get_tree().paused = false


func _on_exit_pressed():
	AudioPlayer.play_sound(sound)
	get_tree().quit()
