extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VideoStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://start_scene/scenes/world.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Title_Screen/Level_select.tscn")
