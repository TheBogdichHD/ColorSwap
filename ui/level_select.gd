extends Control

@onready var sprite_2d = $SpecialButton/Sprite2D
@onready var button_15 = $MarginContainer/VBoxContainer/GridContainer/ButtonQ
@onready var button_16 = $Button16
@onready var player = $Player
@onready var sound = preload("res://assets/sounds/begin.wav")
@onready var soundui = preload("res://assets/sounds/button_ui.wav")

func _ready():
	for i in Save.data["levels"]["level_unlocked"]:
		find_child("Button" + i).disabled = false
	if Save.data["levels"]["in_menu"]:
		player.show()
		player.process_mode = PROCESS_MODE_INHERIT

func _on_back_pressed():
	AudioPlayer.play_sound(soundui)
	get_tree().change_scene_to_file("res://ui/menu.tscn")


func _on_button_pressed(extra_arg_0):
	AudioPlayer.play_sound(sound)
	SceneTransition.change_scene("res://levels/level" + extra_arg_0 + ".tscn")


func _on_button_15_pressed():
	AudioPlayer.play_sound(sound)
	if button_15.text == "?":
		SceneTransition.change_scene("res://levels/levelQ.tscn")
	else:
		Save.data["levels"]["in_menu"] = false
		SceneTransition.change_scene("res://levels/level..tscn")


func _on_special_button_body_entered(_body):
	sprite_2d.frame = 1
	var text = button_15.text
	button_15.text = button_16.text
	button_16.text = text


func _on_special_button_body_exited(_body):
	sprite_2d.frame = 0
