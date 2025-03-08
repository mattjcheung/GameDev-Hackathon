extends Node

@export var circuit_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 4
var screen_size : Vector2i
var ground_height : int
var circuits : Array
const CIRCUIT_DELAY : int = 100
const CIRCUIT_RANGE : int = 200
var time_elapsed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	circuits.clear()
	generate_circuits()
	$Drone.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Drone.flying:
						$Drone.flap()
						check_top()
						

func start_game():
	game_running = true
	$Drone.flying = true
	$Drone.flap()
	$CircuitTimer.start()
	$GameTimer.start()
	
func _process(delta):
	if game_running:
		scroll+= SCROLL_SPEED
		if scroll>=screen_size.x:
			scroll = 0
		$Ground.position.x=-scroll
		for circuit in circuits:
			circuit.position.x -= SCROLL_SPEED
		


func generate_circuits():
		var circuit = circuit_scene.instantiate()
		circuit.position.x = screen_size.x + CIRCUIT_DELAY
		circuit.position.y = (screen_size.y - ground_height)/ 2 + randi_range(-CIRCUIT_RANGE, CIRCUIT_RANGE)
		circuit.hit.connect(drone_hit)
		add_child(circuit)
		circuits.append(circuit)
	
func check_top():
	if $Drone.position.y <0:
		$Drone.falling = true
		stop_game()

func stop_game():
	$CircuitTimer.stop()
	$Drone.flying = false
	game_running=false
	game_over = true
	
func drone_hit():
	$Drone.falling = true
	stop_game()


func _on_circuit_timer_timeout() -> void:
	if time_elapsed == false:
		generate_circuits()

func _on_ground_hit():
	$Drone.falling = false
	stop_game()


func _on_game_timer_timeout() -> void:
	time_elapsed = true
