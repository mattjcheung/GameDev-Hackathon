extends Node2D

const  BULLET = preload("res://TheBossFight/scenes/bullet.tscn")
@onready var muzzle: Marker2D = $Muzzle
@export var fire_rate: float = 0.2  # Time between shots in seconds
@export var bullet_speed: float = 600.0  # Speed of bullets
@onready var muzzle_flash: AnimatedSprite2D = $MuzzleFlash
var can_shoot: bool = true  # Prevents shooting too fast

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Shoot"):
		visible = true
	else :
		visible = false
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		
	if Input.is_action_pressed("Shoot") and can_shoot:
		_fire()
		can_shoot = false
		get_tree().create_timer(fire_rate).timeout.connect(_reset_fire)

		
func _fire():
	var bullet_instance = BULLET.instantiate()
	
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	play_muzzle_flash()
	
func play_muzzle_flash():
	muzzle_flash.show()  # Show muzzle flash
	muzzle_flash.play()  # Play the flash animation
	muzzle_flash.animation_finished.connect(_hide_muzzle_flash)  # Hide when done
	

func _hide_muzzle_flash():
	muzzle_flash.hide()  # Hide flash after animation ends

func _reset_fire():
	can_shoot = true
