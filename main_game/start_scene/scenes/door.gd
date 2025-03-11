extends Node2D

@export var next_scene : PackedScene
@onready var anim = $AnimatedSprite2D  # Ensure the door has an AnimatedSprite2D

var is_locked = true

func unlock():
	if is_locked:
		is_locked = false
		anim.play("open") 
		
func _on_body_entered(body):
	if body.name == "Player":  
		if next_scene:
			await get_tree().create_timer(1.0).timeout  # Delay scene change slightly
			get_tree().change_scene_to_packed(next_scene)
		else:
			print("Error: No next scene assigned!")
