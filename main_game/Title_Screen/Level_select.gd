extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VideoStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_lvl_1_pressed() -> void:
		get_tree().change_scene_to_file("res://start_scene/scenes/world.tscn")
		
func _on_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Lab_Room/Lab_phone.tscn")

func _on_lvl_3_pressed() -> void:
		get_tree().change_scene_to_file("res://Lab_Room/Lab_main_2.tscn")
	
func _on_lvl_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Lab_Room/Lab_main_3.tscn")
