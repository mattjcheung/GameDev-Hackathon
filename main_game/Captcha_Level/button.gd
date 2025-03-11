extends Button

var selected: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if selected:
		selected = false
		$Sprite2D.hide()
	else:
		selected = true
		$Sprite2D.show()
