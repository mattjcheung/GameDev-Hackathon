extends Area2D

signal button_pressed
var times = 0

func _on_body_entered(body: Node2D) -> void:
	if times == 0:
		emit_signal("button_pressed")
		times += 1
