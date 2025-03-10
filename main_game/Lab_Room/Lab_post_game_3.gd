extends Node

signal minigame
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Beacon.activate()
	$Door.open()



func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "monkey":
		get_tree().change_scene_to_file("res://Title_Screen/Menu.tscn")
		
func _on_weapon_part_weapon_1() -> void:
	$monkey.thought_3()
	$Gun.piece_3()


func _on_table_read() -> void:
	$Page.show()
	
func _physics_process(delta):
	# Check input for movement
	if Input.is_action_just_pressed("next"):  # Detects Enter/Return key
		$Page.hide()
