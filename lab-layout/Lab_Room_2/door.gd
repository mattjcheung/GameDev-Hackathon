extends Node2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
signal opened

func open():
	$AnimatedSprite2D.play("opening")
	await $AnimatedSprite2D.animation_finished  # Wait for animation to finish
	$StaticBody2D/collision.set_deferred("disabled", true)# Play animation once
