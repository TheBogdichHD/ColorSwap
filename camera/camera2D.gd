extends Camera2D


@export var target: Node2D
@export var zoom_step = 2
@onready var target_position = target.position
@onready var camera_position = position
@onready var camera_zoom = zoom

var target_zoom = 0.5

var zoom_current = 1.0
var zoomed = true
var zooming = false

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("zoom")) or zooming:
		if zoomed:
			zoom_current = lerp(zoom_current, target_zoom, zoom_step * delta)
			set_zoom(Vector2(zoom_current, zoom_current))
			if abs(zoom_current - target_zoom) < 0.05:
				zoomed = false
				zooming = false
				set_zoom(Vector2(snapped(zoom_current, 0.01), snapped(zoom_current, 0.01)))
			else:
				zooming = true
		else:
			zoom_current = inverse_lerp(zoom_current, target_zoom, zoom_step * delta)
			set_zoom(Vector2(zoom_current, zoom_current))
			if abs(zoom_current - target_zoom) < 0.05:
				zoomed = true
				zooming = false
				set_zoom(Vector2(snapped(zoom_current, 0.01), snapped(zoom_current, 0.01)))
			else:
				zooming = true
