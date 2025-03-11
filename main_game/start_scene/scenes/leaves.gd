extends Area2D

@export var next_scene : PackedScene
@onready var anim = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "Player":  # Ensure only the player triggers it
		play_anim()

		if next_scene:
			await get_tree().create_timer(1.0).timeout  # Delay scene change slightly
			get_tree().change_scene_to_packed(next_scene)
		else:
			print("Error: No next scene assigned!")

func play_anim():
	anim.play("collision")
