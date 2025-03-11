extends Node2D

signal cutscene_finished 
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer

func _ready():
	print("animation")
	animation_player.play("new_animation")
	await animation_player.animation_finished
	print("finished")
	cutscene_finished.emit()
