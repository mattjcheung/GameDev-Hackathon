extends CharacterBody2D

enum BossState { IDLE, MOVE_RANDOM, DASH, LASER_SWEEP, SHOOT, LASER_DANCE, LASER_RAIN\
, GEOMETRIC_HELL}
var current_state = BossState.IDLE

@export var speed: float = 200.0 # Movement speed
@export var dash_speed: float = 400.0
@export var dash_chance: float = 0.05  # 30% chance to dash instead of normal movement
@export var dash_distance: float = 400.0  # How far the boss dashes  # Dash speed
@export var attack_interval: float = 3.0
@export var hover_height: float = 200.0

@export var arena_top: float = -550
@export var arena_bottom: float = -500
@export var arena_left: float = -650
@export var arena_right: float = 650

@onready var move_timer: Timer = $Timers/MoveTimer
@onready var dash_timer: Timer = $Timers/DashTimer
@onready var return_timer: Timer = $Timers/ReturnTimer
@onready var attack_timer: Timer = $Timers/AttackTimer

@onready var player = get_tree().get_first_node_in_group("Players") # Adjust path if needed

#Attack stuff
const  BULLET = preload("res://TheBossFight/scenes/bossBullet.tscn")
const LASER = preload("res://TheBossFight/scenes/laser.tscn")
@export var fire_rate: float = 0.2 
var can_shoot: bool = true
@onready var markers: Node = $Markers

signal game_won
@export var health = 1500
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar

var cant_move = false
var target_position: Vector2
var original_position: Vector2
var is_dashing: bool = false
var can_rotate: bool = true

var tween = create_tween()

func _set_state(new_state):
	current_state = new_state
	match current_state:
		BossState.IDLE:
			if not cant_move:
				move_timer.start(1.0)  # Wait 1 second before moving
		BossState.MOVE_RANDOM:
			_move_randomly()
		BossState.LASER_SWEEP:
			_fire_sweeping_laser()
		BossState.SHOOT:
			_fire_projectiles()
		BossState.LASER_DANCE:
			_fire_laser_dance()
		BossState.LASER_RAIN:
			_rain_lasers()
		BossState.GEOMETRIC_HELL:
			_make_grid()
			


func _ready():
	health_bar.init_health(health)

	move_timer.timeout.connect(_on_move_timer)
	attack_timer.timeout.connect(_on_attack_timer)
	dash_timer.timeout.connect(_perform_dash)
	return_timer.timeout.connect(_return_to_original_position)
	attack_timer.start(attack_interval)
	health_bar.modulate = Color(1, 0, 1, 1)
	

func _on_attack_timer():
	_choose_attack()
	
func _on_move_timer():
	_set_state(BossState.MOVE_RANDOM)

func _physics_process(delta):
	_rotate_toward_player()
		
func _rotate_toward_player():
	if player:
		var direction = (player.global_position - global_position).normalized()
		rotation = direction.angle() - PI / 2   # Adjust for correct facing direction


func _move_randomly():
	# Pick a random position within the defined arena bounds
	var new_x = randf_range(arena_left, arena_right)
	var new_y = randf_range(arena_top, arena_bottom)
	target_position = Vector2(new_x, new_y)
	
	var tween = create_tween()
	var move_duration = randf_range(2.0, 3.0)  # Random movement speed
	tween.tween_property(self, "global_position", target_position, move_duration) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)

	move_timer.start(move_duration + randf_range(0.5, 2.0))  # Random delay before next move
  # Adjust delay before choosing next position

func _prepare_dash():
	can_rotate = false
	move_timer.stop()  # Stop normal movement
	dash_timer.start(.5)  # Wait 1 second before dashing

func _perform_dash():
	if not player:
		return
	# Dash towards the player
	var direction = (player.global_position - global_position).normalized()
	target_position = global_position + (direction * dash_distance)

	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, dash_distance / dash_speed) \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_QUAD)
	#move_timer.start(.5)
	
func _return_to_original_position():
	var tween = create_tween()
	tween.tween_property(self, "global_position", original_position, 0.5) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)
	move_timer.start(0.5)
	attack_timer.start(2)

func _fire_sweeping_laser():
	print("sweeping laser")
	_position_above_player()
	
func _fire_projectiles():
	_position_above_player()
	_fire()

func _fire_laser_dance():
	
	var x = randf_range(arena_left, arena_right)
	var y = randf_range(arena_top, 350)
	for i in range(8):
		var laser_instance = LASER.instantiate()
		get_tree().current_scene.add_child(laser_instance)
		laser_instance.global_position.x = x
		laser_instance.global_position.y = y
		laser_instance.rotation = (player.global_position - laser_instance.global_position).angle()
		await get_tree().create_timer(0.4).timeout

func _rain_lasers():
	for i in range(5):
		randomLaser(90)
	
func _make_grid():
	print("grid")
	_position_above_player()
	for i in range(5):
		randomLaser(90)
	for i in range(5):
		randomLaser(0)

# LASER_SWEEP, SHOOT, LASER_DANCE, LASER_RAIN GEOMETRIC_HELL
func _choose_attack():
	var random_choice = randi_range(0,5)
	
	if random_choice == 1||random_choice == 0:
		_set_state(BossState.SHOOT)
		attack_timer.start(5)
	elif random_choice == 2:
		_set_state(BossState.LASER_DANCE)
		attack_timer.start(5)
	elif random_choice == 3:
		_set_state(BossState.LASER_RAIN)
		attack_timer.start(5)
	elif random_choice == 4:
		_set_state(BossState.GEOMETRIC_HELL)
		attack_timer.start(5)
	
func _position_above_player():
	if player:
		cant_move = true 
		move_timer.stop()
		var target_position = player.global_position + Vector2(0, -hover_height)

		var tween = create_tween()
		tween.tween_property(self, "global_position", target_position, 0.5) \
			.set_ease(Tween.EASE_IN_OUT) \
			.set_trans(Tween.TRANS_SINE)

		tween.finished.connect(_unlock_movement)

func randomLaser(angle):
	var x = randf_range(arena_left, arena_right)
	var y = randf_range(arena_top, 350)
	var laser_instance = LASER.instantiate()
	get_tree().current_scene.add_child(laser_instance)
	laser_instance.global_position.x = x
	laser_instance.global_position.y = y
	laser_instance.rotation = angle


func _fire():
	
	for marker in markers.get_children():
		var bullet_instance = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = marker.global_position
		bullet_instance.rotation = (player.global_position - marker.global_position).angle()
		await get_tree().create_timer(0.2).timeout

func _unlock_movement():
	cant_move = false
	move_timer.start(3.0)

func _die():
	emit_signal("game_won")
	queue_free()
	
func take_damage(damage):
	var value = health - damage
	_set_health(value)
	
func _set_health(value):
	health = value
	if health <= 0:
		_die()
	health_bar.health = health
