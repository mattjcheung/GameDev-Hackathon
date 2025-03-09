extends Node

signal minigame
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_access_panel_access() -> void:
	get_tree().change_scene_to_file("res://Drone_Level/Drone_Level.tscn")
	
