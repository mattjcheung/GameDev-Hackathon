extends Node2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	play_anim()

func play_anim():
	anim.play("default")
	anim.connect("animation_finished", Callable(self, "_on_animation_finished"))  # Stop when done

func _on_animation_finished():
	anim.stop()  # Stops the animation once it completes
