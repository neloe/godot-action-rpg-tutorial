extends KinematicBody2D


var velocity = Vector2.ZERO

const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = 10


# Called when the node enters the scene tree for the first time.
	
func _physics_process(delta):
	# Bad way
	#if Input.is_action_pressed("ui_right"):
	#	velocity.x = speed
	#elif Input.is_action_pressed("ui_left"):
	#	velocity.x = -speed
	#elif Input.is_action_pressed("ui_up"):
	#	velocity.y = -speed
	#elif Input.is_action_pressed("ui_down"):
	#	velocity.y = speed
	#else:
	#	velocity.x = 0
	#	velocity.y = 0
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta) 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	print(velocity)
	move_and_collide(velocity)
