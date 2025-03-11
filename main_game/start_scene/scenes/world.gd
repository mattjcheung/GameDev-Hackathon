extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle")

func play_anim():
	pass
	
func stop_anim() -> void:
	anim.stop()
