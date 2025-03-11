extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	randomize()  # Ensure randomness is properly seeded
	var random_fps = randf_range(4.0, 9.0)  # Adjust the range as needed
	anim.speed_scale = random_fps / anim.sprite_frames.get_animation_speed("idle")
	anim.play("idle")

func play_anim():
	pass

func stop_anim() -> void:
	anim.stop()
