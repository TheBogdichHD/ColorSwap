extends Node2D

@export var next_level: String
@export var prev_level: String

var can_go_to_next_level = false

func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("next"):
		get_tree().change_scene_to_file(next_level)
	if event.is_action_pressed("prev"):
		get_tree().change_scene_to_file(prev_level)
	if Input.is_action_pressed("enter_door") and can_go_to_next_level:
		get_tree().change_scene_to_file(next_level)

func _ready():
	$Door.connect("door_entered", _on_door_body_entered)
	$Door.connect("door_exited", _on_door_body_exited)


func _on_door_body_entered():
	can_go_to_next_level = true


func _on_door_body_exited():
	can_go_to_next_level = false
