extends TileMap

var board_size = 4
enum Layers{hidden,revealed}
var SOURCE_NUM = 0
const hidden_tile_coords = Vector2(6,2)
const hidden_tile_alt = 1
var revealed_spots = []
var tile_pos_to_atlas_pos = {}
var Attempts = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_board()
	update_text()
	pass # Replace with function body.

func get_tiles_to_use():
	var chosen_tile_coords = []
	var options = range(10)
	options.shuffle()
	for i in range(board_size * int(board_size / 2)):
		var current = Vector2(options.pop_back(), 1)
		for j in range(2):
			chosen_tile_coords.append(current)
	chosen_tile_coords.shuffle()
	return chosen_tile_coords

func setup_board():
	var cards_to_use = get_tiles_to_use()
	for y in range(board_size):
		for x in range(board_size):
			var current_spot = Vector2(x, y)
			place_single_face_down_card(current_spot)
			var card_atlas_coords = cards_to_use.pop_back()
			tile_pos_to_atlas_pos[current_spot] = card_atlas_coords
			self.set_cell(Layers.revealed, current_spot, 
						SOURCE_NUM, card_atlas_coords)


func place_single_face_down_card(coords: Vector2):
	self.set_cell(Layers.hidden, coords, 
				SOURCE_NUM, hidden_tile_coords, hidden_tile_alt)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = Vector2(local_to_map(to_local(global_clicked)))
			print(pos_clicked)
			var current_tile_alt = get_cell_alternative_tile(Layers.hidden, pos_clicked)
			if current_tile_alt == 1 and revealed_spots.size() < 2:
				self.set_cell(Layers.hidden, pos_clicked, -1)
				revealed_spots.append(pos_clicked)
				if revealed_spots.size() == 2:
					when_two_cards_revealed()

func when_two_cards_revealed():
	# the cards match
	if tile_pos_to_atlas_pos[revealed_spots[0]] == tile_pos_to_atlas_pos[revealed_spots[1]]:
		revealed_spots.clear()
	else:
		# the cards did not match
		put_back_cards_with_delay()
		update_text()

func update_text():
	$"../CanvasLayer/attempts_label".text = "Attempts remaining: %d" % Attempts

func update_text_to_red():
	$"../CanvasLayer/attempts_label_red".text = "Attempts remaining: %d" % Attempts
	
func play_gong():
	$"../gong".play()
	
func play_game_over():
	$"../CanvasLayer/VideoStreamPlayer".play()
func remove_red_text():
	$"../CanvasLayer/attempts_label_red".text = " "
	
func put_back_cards_with_delay():
	if Attempts == 1:
		play_game_over()
		Attempts -= 1
		update_text_to_red()
		await get_tree().create_timer(1.5).timeout
		remove_red_text()
		update_text()
		for spot in revealed_spots:
			place_single_face_down_card(spot)
		
		revealed_spots.clear()
	else:
		play_gong()
		Attempts -= 1
		update_text_to_red()
		await get_tree().create_timer(1.5).timeout
		remove_red_text()
		update_text()
		for spot in revealed_spots:
			place_single_face_down_card(spot)
		
		revealed_spots.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
