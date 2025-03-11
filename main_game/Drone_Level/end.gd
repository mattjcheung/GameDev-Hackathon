extends CanvasLayer

signal return_lab




	


func _on_restart_button_pressed() -> void:
	return_lab.emit()
