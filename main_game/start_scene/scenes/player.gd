extends CharacterBody2D

const ACCELERATION = 960.0
const MAX_SPEED = 300.0
const FRICTION = 900.0
const GRAVITY = 2000.0
const JUMP_FORCE = 1000.0


@onready var animPlayer = $PlayerSprite/AnimationPlayer
@onready var animTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")


func _ready():
	animTree.active = true

func _physics_process(delta):
	velocity.y += GRAVITY * delta

	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_x = sign(input_x)

	# **Jump Logic**
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_FORCE
			animState.travel("Jump")

	# **Animation & Movement Logic**
	if input_x != 0:  # If moving left or right
		set_blend_position(input_x)  
		if is_on_floor():
			animState.travel("Walk")
		else:
			animState.travel("FallLoop")
		velocity = velocity.move_toward(Vector2(input_x * MAX_SPEED, velocity.y), ACCELERATION * delta)
	else:  # If no input
		if is_on_floor():
			animState.travel("Idle")  # Force idle when standing still
		else:
			animState.travel("FallLoop")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity.y = clamp(velocity.y, -1800, 1800)
	move_and_slide()

func set_blend_position(input_x: int) -> void:
	animTree.set("parameters/Idle/blend_position", input_x)
	animTree.set("parameters/Walk/blend_position", input_x)
	animTree.set("parameters/Jump/blend_position", input_x)
	animTree.set("parameters/FallLoop/blend_position", input_x)
