extends CanvasLayer


func _unhandled_input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
