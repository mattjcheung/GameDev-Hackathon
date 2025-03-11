extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label
@onready var collision_shape_2d: CollisionShape2D = $door

var can_open = false
var wrench_collected = false
@onready var wrench = get_tree().get_first_node_in_group("wrench")
# Called when the node enters the scene tree for the first time.
	

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	wrench.wrench_collected.connect(_on_wrench_collected)

func _on_wrench_collected():
	can_open = true

func _on_interact():
	if can_open and interaction_area.can_interact:
		animated_sprite_2d.play("open")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("default")
		collision_shape_2d.disabled = true
		interaction_area.can_interact = false
	elif interaction_area.can_interact:
		print("hi")
		label.visible = true
		animated_sprite_2d.play("closed")
		await get_tree().create_timer(2.0).timeout
		label.visible = false

func unlock():
	can_open = true
