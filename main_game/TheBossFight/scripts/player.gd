extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var step_height = 10

const HEALTH = 500
const DASH_SPEED = 600.0  # Dash speed
const DASH_DURATION = 0.2  # Dash time in seconds
const DASH_COOLDOWN = 0.5  # Time before you can dash again
var can_dash = true
var is_dashing = false
signal game_lost

var max_jumps = 2  # Allow double jump
var jump_count = 0  # Tracks how many jumps have been used

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $dash_timer
@onready var dash_cooldown_timer: Timer = $dash_cooldown_timer
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@export var canDouble: bool = false


var health = HEALTH

func _ready() -> void:
	dash_timer.timeout.connect(_end_dash)
	dash_cooldown_timer.timeout.connect(_reset_dash)
	health_bar.init_health(HEALTH)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or ((jump_count < max_jumps) && canDouble)):
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	if is_on_floor():
		jump_count = 0
	
	if Input.is_action_just_pressed("Dash") and can_dash and not is_dashing:
		start_dash()
	
	if is_dashing:
		move_and_slide()
		return
	
	if Input.is_action_pressed("down") or Input.is_action_just_pressed("ui_s") and is_on_floor():
		position.y += 1
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	var mouse_position = get_global_mouse_position()  # Get the mouse position
	var facing_right = mouse_position.x > global_position.x
	
	if Input.is_action_pressed("Shoot"):
		animated_sprite.flip_h = not facing_right
	else:
		if direction < 0:
			animated_sprite.flip_h = true
		elif direction > 0:
			animated_sprite.flip_h = false
	
	
	if is_on_floor():
		if Input.is_action_pressed("Shoot"):
			if direction == 0:
				animated_sprite.play("PlayerIdleGun")
			else:
				animated_sprite.play("PlayerRunGun")
		else:
			if direction == 0:
				animated_sprite.play("Idle")
			else:
				animated_sprite.play("Run")
	else:
		if Input.is_action_pressed("Shoot"):
			animated_sprite.play("PlayerIdleGun")
		elif Input.is_action_pressed("jump"):
			if (jump_count == 0):
				animated_sprite.play("jump")
			elif canDouble:
				animated_sprite.play("DoubleJump")

	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
func _end_dash():
	is_dashing = false
	velocity.x = 0 
	dash_cooldown_timer.start(DASH_COOLDOWN)

func start_dash():
	is_dashing = true
	can_dash = false
	velocity.x = DASH_SPEED if animated_sprite.flip_h == false else -DASH_SPEED
	dash_timer.start(DASH_DURATION) 
	
func _reset_dash():
	print("dash")
	can_dash = true 
	
func _die():
	animated_sprite.play("PlayerDeath")
	await get_tree().create_timer(2.0).timeout
	game_lost.emit()
	
func take_damage(damage):
	animated_sprite.modulate = Color(1, 0, 0, 1)  # Set to red
	await get_tree().create_timer(0.2).timeout  # Wait 0.2 seconds
	animated_sprite.modulate = Color(1, 1, 1, 1)  # Reset to normal
	var value = health - damage
	_set_health(value)
	
func _set_health(value):
	health = value
	if health <= 0:
		_die()
	if health_bar:
		health_bar.health = health
