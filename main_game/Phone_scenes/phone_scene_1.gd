extends Node2D


var dialogue_images = [
	preload("res://Phone_scenes/assets/phone dialogue_1.png"),
	preload("res://Phone_scenes/assets/phone dialogue_2.png"),
	preload("res://Phone_scenes/assets/phone dialogue_3.png"),
	preload("res://Phone_scenes/assets/phone dialogue_4.png")
]

var current_index = 0

@onready var sprite = $dialogue
@onready var button = $NextButton

func _ready():
	sprite.texture = dialogue_images[current_index]  # Set first dialogue image
	$phone_sprite/AnimatedSprite2D.play("default")

func _physics_process(delta):
	# Check input for movement
	if Input.is_action_just_pressed("next"):  # Detects Enter/Return key
		advance_dialogue()
	
func advance_dialogue():
	current_index += 1
	if current_index < dialogue_images.size():
		sprite.texture = dialogue_images[current_index]  # Update image
	else:
		get_tree().change_scene_to_file("res://Lab_Room/Lab_main.tscn")  # Disable button when dialogue ends
