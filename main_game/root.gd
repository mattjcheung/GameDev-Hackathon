extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().change_scene("res://Lab_Room_2/Lab_main.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_main_minigame() -> void:
	get_tree().change_scene("res://Drone_Level/Drone_Level.tscn")
