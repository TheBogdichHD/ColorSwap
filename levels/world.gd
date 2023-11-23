extends Node2D

@export var next_level: String

func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _ready():
	RenderingServer.set_default_clear_color(Color.DEEP_SKY_BLUE)


func _on_door_body_entered(_body):
	get_tree().change_scene_to_file(next_level)
