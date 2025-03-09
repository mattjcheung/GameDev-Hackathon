extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_access_panel_access() -> void:
	$Beacon.activate()
	$Door.open()
