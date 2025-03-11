extends Node2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var start_boss = true
signal beginBattle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	if start_boss and interaction_area.can_interact:
		animated_sprite_2d.play("Beacon On")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("Beacon static on")
		animated_sprite_2d.play("closed")
		await get_tree().create_timer(10.0).timeout
		emit_signal("beginBattle")
		animated_sprite_2d.play("EvilBeacon")
		start_boss = false
		
