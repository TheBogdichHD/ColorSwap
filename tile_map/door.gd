extends Area2D

signal door_entered
signal door_exited

@onready var button = $Button


func _on_body_entered(_body):
	door_entered.emit()
	button.show()


func _on_body_exited(_body):
	button.hide()
	door_exited.emit()
