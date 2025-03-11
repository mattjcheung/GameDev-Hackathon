extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button = get_tree().get_first_node_in_group("button")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.button_pressed.connect(_on_button_pressed)


func _on_button_pressed():
	animation_player.play("move")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
