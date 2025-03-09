extends Node

signal minigame
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Beacon.activate()
	$Door.open()
