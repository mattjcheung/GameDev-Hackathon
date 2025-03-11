extends TileMap

var boardSize = 4
enum Layers { hidden, revealed } #Hidden vs Revealed blocks
var sourceNum = 0 
const BlockCoords = Vector2(6, 2) # changing this breaks it idk why
const BlockAlt = 1 #chooses which alternative tile to be the cover
var revealedSpots = []
var blockToAtlasPosition = {}
var attempts = 3 #attempts remaining (10 seems best)

func _ready() -> void:
	setup_blocks()
	update_text()
	pass 

#shuffle and choose random set of blocks to use
func chooseBlocks(): 
	var chosenBlockCoords = []
	var options = range(10)
	options.shuffle()
	for i in range(boardSize * int(boardSize / 2)):
		var current = Vector2(options.pop_back(), 1)
		for j in range(2):
			chosenBlockCoords.append(current)
	chosenBlockCoords.shuffle()
	return chosenBlockCoords

func setup_blocks():
	var blocksToUse = chooseBlocks()
	for y in range(boardSize):
		for x in range(boardSize):
			var currentSpot = Vector2(x, y)
			place_hidden_block(currentSpot)
			var blockAtlasCoords = blocksToUse.pop_back()
			blockToAtlasPosition[currentSpot] = blockAtlasCoords
			self.set_cell(Layers.revealed, currentSpot, 
						sourceNum, blockAtlasCoords)


func place_hidden_block(coords: Vector2):
	self.set_cell(Layers.hidden, coords, 
				sourceNum, BlockCoords, BlockAlt)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var globalClicked = event.position
			var posClicked = Vector2(local_to_map(to_local(globalClicked)))
			print(posClicked)
			var currentTileAlt = get_cell_alternative_tile(Layers.hidden, posClicked)
			if currentTileAlt == 1 and revealedSpots.size() < 2:
				self.set_cell(Layers.hidden, posClicked, -1)
				revealedSpots.append(posClicked)
				if revealedSpots.size() == 2:
					match_found()

func match_found():
	# blocks match
	if blockToAtlasPosition[revealedSpots[0]] == blockToAtlasPosition[revealedSpots[1]]:
		revealedSpots.clear()
	else:
		# blocks didnt match
		match_failed()
		update_text()

func update_text():
	$"../CanvasLayer/attempts_label".text = "Attempts remaining: %d" % attempts

func update_text_to_red():
	$"../CanvasLayer/attempts_label_red".text = "Attempts remaining: %d" % attempts

func play_gong():
	$"../gong".play()
	
func play_game_over():
	$"../CanvasLayer/VideoStreamPlayer".play()

func remove_red_text():
	$"../CanvasLayer/attempts_label_red".text = " "
	
func match_failed():
	if attempts == 1:   #if they fail on last attempt
		play_game_over() #game over
		attempts -= 1
	if attempts > 1:   #if not on last attempt
		play_gong()   # play gong
		
	attempts -= 1        #minus attempts and delay so they can process it
	update_text_to_red()
	await get_tree().create_timer(1.5).timeout
	remove_red_text()
	update_text()
	for spot in revealedSpots:
		place_hidden_block(spot)
	
	revealedSpots.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
