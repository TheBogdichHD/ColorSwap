extends Node2D

@export var next_level: String = ""
@export var music_name = "res://assets/music/Dream_Culture.mp3"
var can_go_to_next_level = false
@onready var door_sound = preload("res://assets/sounds/door_open.wav")
@onready var restart_sound = preload("res://assets/sounds/restart.wav")

func _unhandled_input(event):
	if Input.is_action_just_pressed("pause_menu"):
		$PauseMenu.show()
		get_tree().paused = true
	if event.is_action_pressed("restart"):
		AudioPlayer.play_sound(restart_sound)
		SceneTransition.change_scene(get_tree().current_scene.scene_file_path)
	if Input.is_action_pressed("enter_door") and can_go_to_next_level:
		AudioPlayer.play_sound(door_sound)
		if next_level == "res://ui/level_select.tscn":
			Save.data["levels"]["in_menu"] = true
			SceneTransition.change_scene("res://ui/level_select.tscn")
		elif next_level == "thank you":
			SceneTransition.change_scene_final("res://levels/thank_you.tscn")
		else:
			if next_level not in Save.data["levels"]["level_unlocked"]:
				Save.data["levels"]["level_unlocked"].append(next_level)
			SceneTransition.change_scene("res://levels/level" + next_level + ".tscn")


func _ready():
	MusicPlayer.play_music(load(music_name))
	find_child("Door").connect("door_entered", _on_door_body_entered)
	find_child("Door").connect("door_exited", _on_door_body_exited)


func _on_door_body_entered():
	can_go_to_next_level = true


func _on_door_body_exited():
	can_go_to_next_level = false
