extends Area2D

# Called when the node enters the scene tree for the first time.

signal wrench_collected

func _on_body_entered(body: Node2D) -> void:
	emit_signal("wrench_collected")
	queue_free()
