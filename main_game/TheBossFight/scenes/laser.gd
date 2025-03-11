extends Area2D

@export var damage: int = 80
@onready var animation_player: AnimationPlayer = $Line2D/AnimationPlayer
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var line_2d: Line2D = $Line2D

var can_damage = false
var bodies = []
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.visible = false
	var random_color = Color(randf(), randf(), randf(), 1)  # Random RGB color
	line_2d.default_color = random_color
	can_damage = false
	_fade_in()

func _fade_in():
	animation_player.play("LaserFires")
	line_2d.visible = true
	await animation_player.animation_finished
	animation_player
	can_damage = true
	await get_tree().create_timer(.2).timeout
	can_damage = false
	animation_player.play("FadeOut")
	await animation_player.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		bodies.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body in bodies:
		bodies.erase(body)
		
func _process(delta):
	if can_damage:
		for body in bodies:
			if body.has_method("take_damage"):
				body.take_damage(damage)
				can_damage = false
				
