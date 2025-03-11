extends RigidBody2D


@export var push_force: float = 200  # Adjust push strength

func _on_area_2d_body_entered(body):
	if body.name == "Player":  # Make sure it's the player
		var player_direction = (body.global_position - global_position).normalized()
		
		# Only allow pushing from the left or right
		if abs(player_direction.x) > abs(player_direction.y):  
			apply_impulse(Vector2(player_direction.x * push_force, 0))
