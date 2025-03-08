extends Area2D

signal hit

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	hit.emit()
	print("hit")
