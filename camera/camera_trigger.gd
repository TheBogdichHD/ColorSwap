extends Area2D

signal trigger_entered(pos)


@export var cam_pos: Vector2

func _on_body_entered(_body):
	trigger_entered.emit(cam_pos)
