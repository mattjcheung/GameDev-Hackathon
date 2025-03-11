extends Area2D
class_name InteractionArea

@export var action_name: String = "to interact"
var can_interact = true

var interact: Callable = func():
	pass

func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)


func _on_body_entered(body: Node2D) -> void:
	if can_interact:
		InteractionManager.register_area(self)
