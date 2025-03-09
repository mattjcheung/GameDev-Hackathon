extends Area2D


signal hit
var x = 555
var y = 532

func _ready():
	body_entered.connect(_on_body_entered)


func start():
	$Sprite2D.visible = false
	$Sprite2D2.visible = false
	$CollisionShape2D.disabled = true
	position.x = x
	position.y = y
	
func appear():
	$Sprite2D.visible = true

	$CollisionShape2D.disabled = false
	
	
func _on_body_entered(body):
	hit.emit()
	$Sprite2D2.visible = true
	$Sprite2D.visible = false
	
