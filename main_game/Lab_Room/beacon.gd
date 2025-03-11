extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Off.show()
	$On.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	$Off.hide()
	$On.show()
	$On.play("on_sequence")
	await $On.animation_finished 
	$On.play("default")
