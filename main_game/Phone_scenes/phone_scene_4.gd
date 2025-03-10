extends Node2D

func _ready():
	$phone_sprite/AnimatedSprite2D.play("default")

func _physics_process(delta):
	# Check input for movement
	if Input.is_action_just_pressed("next"):  # Detects Enter/Return key
		get_tree().change_scene_to_file("res://Lab_Room/Lab_post_game_3.tscn")
	
