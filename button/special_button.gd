extends Area2D

@onready var sprite_2d = $Sprite2D


func _on_body_entered(_body):
	sprite_2d.frame = 1
	


func _on_body_exited(_body):
	sprite_2d.frame = 0
