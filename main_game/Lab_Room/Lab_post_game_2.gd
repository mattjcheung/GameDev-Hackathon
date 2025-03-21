extends Node

signal minigame
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Beacon.activate()
	$Door.open()



func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "monkey":
		get_tree().change_scene_to_file("res://Phone_scenes/phone_scene_3.tscn")
		
func _on_weapon_part_weapon_1() -> void:
	$monkey.thought_2()
	$Gun.piece_2()


func _on_table_read() -> void:
	$Page.show()
	
func _physics_process(delta):
	# Check input for movement
	if Input.is_action_just_pressed("next"):  # Detects Enter/Return key
		$Page.hide()
