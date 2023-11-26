extends CharacterBody2D

@export var movement_data : PlayerMovementData

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var animated_sprite_2d = $AnimatedSprite2D

var buffered_jump = false


func _physics_process(delta):
	apply_gravity(delta)
	var input_axis = Input.get_axis("move_left", "move_right")
	
	if input_axis == 0 and is_on_floor():
		animated_sprite_2d.play("default")
	else:
		animated_sprite_2d.play("walk")
	
	if input_axis < 0:
		animated_sprite_2d.flip_h = true
	elif input_axis > 0:
		animated_sprite_2d.flip_h = false
	
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("jump")
	handle_jump()
	
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor():
		coyote_jump_timer.start()


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta


func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump") or buffered_jump:
			coyote_jump_timer.stop()
			buffered_jump = false
			velocity.y = movement_data.jump_velocity
			$JumpSound.play()
	if not is_on_floor():
		if Input.is_action_just_released("jump"):
			if velocity.y < movement_data.jump_velocity / 2:
				velocity.y = movement_data.jump_velocity / 2
		
		if Input.is_action_just_pressed("jump"):
			buffered_jump = true
			jump_buffer_timer.start()


func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)


func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_acceleration * delta)


func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)


func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)


func _on_jump_buffer_timer_timeout():
	buffered_jump = false
