extends CharacterBody2D

@export var speed: float = 200  # Adjust movement speed

func _physics_process(delta):
	var direction = Vector2.ZERO  # Stores movement direction

	# Check input for movement
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	# Normalize direction to prevent faster diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	# Set velocity and move the player
	velocity = direction * speed
	move_and_slide()
