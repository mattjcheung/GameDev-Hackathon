extends Area2D

@export var door: Node2D  
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	play_anim()

func play_anim():
	anim.play("default")

func _on_body_entered(body):
	if body.name == "Player":  
		queue_free()  # Remove key from scene
		door.unlock()
