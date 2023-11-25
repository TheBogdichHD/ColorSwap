extends Camera2D


@export var target: Node2D
@export var zoom_step = 0.08
@onready var target_position = target.position
@onready var camera_position = position
@onready var camera_zoom = zoom

@export var target_zoom = Vector2(0.3, 0.3)
var zoomed = true
var zooming = false
var moving = false

func _ready():
	var triggers = []
	for i in range(1, 10):
		var trigger = get_parent().find_child("CameraTrigger" + str(i))
		if trigger != null:
			triggers.append(trigger)
	for trigger in triggers:
		trigger.connect("trigger_entered", move_camera)

func _process(_delta):
	if (Input.is_action_just_pressed("zoom")) or zooming:
		zooming = true
		if zoomed:
			zoom = zoom.lerp(target_zoom, zoom_step)
			position = position.lerp(target_position, zoom_step)
			if abs(zoom.x - target_zoom.x) < 0.05:
				zoomed = false
				zoom = zoom.snapped(Vector2(0.01, 0.01))
				position = position.snapped(Vector2(0.01, 0.01))
				zooming = false
		else:
			zoom = zoom.lerp(camera_zoom, zoom_step)
			position = position.lerp(camera_position, zoom_step)
			if abs(zoom.x - camera_zoom.x) < 0.05:
				zoomed = true
				zoom = zoom.snapped(Vector2(0.01, 0.01))
				position = position.snapped(Vector2(0.01, 0.01))
				zooming = false
	elif zoomed and moving:
		position = position.lerp(camera_position, zoom_step)
		if abs(zoom.x - camera_position.x) < 0.05:
			position = position.snapped(Vector2(0.01, 0.01))
			moving = false

func move_camera(pos):
	camera_position = pos
	moving = true
