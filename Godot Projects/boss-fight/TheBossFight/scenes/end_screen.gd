extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect button signals
	$TryagainB.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	$MenuB.connect("pressed", Callable(self, "_on_main_menu_button_pressed"))

func _on_restart_button_pressed():
	
	get_tree().change_scene_to_file("res://TheBossFight/scenes/boss_battle.tscn")

func _on_main_menu_button_pressed():
	print("MAIN MENU")
	#get_tree().change_scene_to_file("res://path_to_your_main_menu_scene.tscn")
