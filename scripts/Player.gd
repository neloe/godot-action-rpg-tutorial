extends KinematicBody2D

# Neat!
enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

#var animationPlayer = null
#func _ready():
#	animationPlayer = $AnimationPlayer

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')
# Called when the node enters the scene tree for the first time.
	
func _ready():
	animationTree.active = true
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)

func move_state(delta):
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
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		animationTree.set('parameters/Attack/blend_position', input_vector)
		animationState.travel('Run')
		#if input_vector.x > 0:
		#	animationPlayer.play("RunRight")
		#else:
		#	animationPlayer.play("RunLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		#velocity += input_vector * ACCELERATION * delta
		#velocity = velocity.clamped(MAX_SPEED)
	else:
		#animationPlayer.play("IdleRight")
		animationState.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# this returns the new velocity
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel('Attack')

func attack_animation_finished():
	state = MOVE
