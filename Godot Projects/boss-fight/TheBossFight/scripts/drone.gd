extends StaticBody2D

const SPEED = 60
const HEALTH = 50

var direction = 1
@onready var ray_cast_right: RayCast2D = $rayCastRight
@onready var ray_cast_left: RayCast2D = $rayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar

@export var health = 50

func _ready() -> void:
	health = HEALTH
	health_bar.init_health(HEALTH)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health == HEALTH:
		health_bar.visible = false
	else:
		health_bar.visible = true
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1	
		animated_sprite_2d.flip_h = false

	
	position.x += direction * SPEED * delta

func _die():
	queue_free()
	
func take_damage(damage):
	var value = health - damage
	_set_health(value)
	
func _set_health(value):
	health = value
	if health <= 0:
		_die()
	health_bar.health = value
	
