extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func piece_1():
	$gun1.show()
	$back.show()
	$ShowTimer.start()
	
func piece_2():
	$gun1.show()
	$gun2.show()
	$back.show()
	$ShowTimer.start()

func piece_3():
	$gun.show()
	$back.show()
	$ShowTimer.start()

func _on_show_timer_timeout() -> void:
	$gun1.hide()
	$gun2.hide()
	$gun.hide()
	$back.hide()
