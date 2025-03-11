extends Node2D
@onready var beacon: Node2D = $Beacon
@onready var player: CharacterBody2D = $Player
@onready var scene_1: VideoStreamPlayer = $Player/Camera2D/Scene1
@onready var scene_2: VideoStreamPlayer = $Player/Camera2D/Scene2
@onready var camera_2d: Camera2D = $Player/Camera2D

const BOSS = preload("res://TheBossFight/scenes/boss.tscn")
var boss = null

func _ready() -> void:
	beacon.beginBattle.connect(_on_beacon)

# Called when the node enters the scene tree for the first time.
func _on_beacon():
	await get_tree().process_frame
	var game_manager = get_tree().get_first_node_in_group("Manager")
	_start_cutscene()

func _start_cutscene():
	camera_2d.position_smoothing_enabled = false
	scene_1.play()

func _start_boss_fight():
	if boss == null:
		boss = BOSS.instantiate()
		boss.global_position.x = 30
		boss.global_position.y = -272
		add_child(boss)
		
		boss.game_won.connect(_on_boss_defeated)
		player.game_lost.connect(_on_player_defeated)
	

func _on_boss_defeated():
	print("Boss defeated! Showing win menu.")
	get_tree().change_scene_to_file("res://TheBossFight/scenes/end_screen.tscn")
	
func _on_player_defeated():
	print("Player defeated! Showing lose menu.")
	get_tree().change_scene_to_file("res://TheBossFight/scenes/end_screen.tscn")

func _on_scene_1_finished() -> void:
	scene_2.play()

func _on_scene_2_finished() -> void:
	scene_1.queue_free()  # Remove video players
	scene_2.queue_free()
	camera_2d.position_smoothing_enabled = true

	_start_boss_fight()
