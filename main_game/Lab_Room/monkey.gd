extends CharacterBody2D

@export var speed: float = 200  # Adjust movement speed

func _ready():
	$weapon1_thought.hide()
	$weapon2_thought.hide()
	$weapon3_thought.hide()
	$weapon4_thought.hide()
	$AnimatedSprite2D.play("default")
	
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
	
func thought_1():
	$weapon1_thought.show()
	$thoughtTimer.start()
	
func thought_2():
	$weapon2_thought.show()
	$thoughtTimer.start()
	
func thought_3():
	$weapon3_thought.show()
	$thoughtTimer.start()
	
func thought_4():
	$weapon4_thought.show()
	$thoughtTimer.start()
	
	

func _on_thought_timer_timeout() -> void:
	$weapon1_thought.hide()
	$weapon2_thought.hide()
	$weapon3_thought.hide()
	$weapon4_thought.hide()
