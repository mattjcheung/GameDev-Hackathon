extends Area2D

const SPEED = 400
@export var damage: int = 40 

func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("Players"):
	 	
		if body.has_method("take_damage"):
			body.take_damage(damage) 
	queue_free()
