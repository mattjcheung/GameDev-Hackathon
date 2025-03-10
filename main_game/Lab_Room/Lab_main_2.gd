extends Node

signal minigame
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_access_panel_access() -> void:
	get_tree().change_scene_to_file("res://Drone_Level/Drone_Level.tscn")
	


func _on_weapon_part_weapon_1() -> void:
	$monkey.thought_1()


func _on_table_read() -> void:
	$Page.show()
	
func _physics_process(delta):
	# Check input for movement
	if Input.is_action_just_pressed("next"):  # Detects Enter/Return key
		$Page.hide()
