extends Node2D

@onready var scene_container: Node2D = $SceneContainer
@onready var cutscene_container: Node2D = $CutsceneContainer

var current_scene: Node = null
var is_cutscene_playing: bool = false  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	load_scene(preload(("res://TheBossFight/scenes/game.tscn")))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_scene(new_scene: PackedScene):
	if current_scene:
		scene_container.remove_child(current_scene)
		current_scene.queue_free()  # Remove old scene

	current_scene = new_scene.instantiate()
	scene_container.add_child(current_scene)


func play_cutscene(cutscene_scene: PackedScene):
	if is_cutscene_playing:
		return  # Prevent multiple cutscenes from running at once

	is_cutscene_playing = true
	get_tree().paused = true  #  Pause all gameplay

	var cutscene = cutscene_scene.instantiate()
	cutscene_container.add_child(cutscene)  # Add cutscene inside the main game

	# Wait for the cutscene to finish
	await cutscene.cutscene_finished

	cutscene_container.remove_child(cutscene)
	cutscene.queue_free()

	get_tree().paused = false 
	is_cutscene_playing = false
