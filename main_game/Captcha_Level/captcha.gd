extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_verify_pressed() -> void:
	if $Image_1.selected and $Image_2.selected and $Image_3.selected and $Image_4.selected and $Image_5.selected and $Image_6.selected and $Image_7.selected and $Image_9.selected and not $Image_8.selected:
		get_tree().change_scene_to_file("res://Phone_scenes/phone_scene_4.tscn")
