extends Area2D

@export var objects: Array[Node2D]
@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player = $AudioStreamPlayer


func _on_body_entered(_body):
	audio_stream_player.pitch_scale += randf_range(-0.4, 0.6)
	audio_stream_player.play()

	sprite_2d.frame = 1
	if objects.size() > 1 and not null in objects:
		var positions = []
		var rotations = []
		for object in objects:
			positions.append(object.position)
			rotations.append(object.rotation)
		
		for i in objects.size():
			objects[i].position = positions[(i+1) % objects.size()]
			objects[i].rotation = rotations[(i+1) % objects.size()]


func _on_body_exited(_body):
	sprite_2d.frame = 0
