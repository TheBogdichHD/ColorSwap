extends Node2D

@export var next_level: String
@export var prev_level: String

var can_go_to_next_level = false


func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		SceneTransition.change_scene(get_tree().current_scene.scene_file_path)
	if event.is_action_pressed("next"):
		SceneTransition.change_scene(next_level)
	if event.is_action_pressed("prev"):
		SceneTransition.change_scene(prev_level)
	if Input.is_action_pressed("enter_door") and can_go_to_next_level:
		SceneTransition.change_scene(next_level)


func _ready():
	find_child("Door").connect("door_entered", _on_door_body_entered)
	find_child("Door").connect("door_exited", _on_door_body_exited)


func _on_door_body_entered():
	can_go_to_next_level = true


func _on_door_body_exited():
	can_go_to_next_level = false
