extends Node2D


# variables
var board = [[null, null, null], [null, null, null], [null, null, null]] # 3x3 grid
var currentPlayer = "X" # Start with X
var gameOver = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_cell_pressed(cellIndex):
	
	if gameOver:
		return
	var row = (cellIndex / 3) # int division for row
	var col = (cellIndex % 3) # modulo for column
	if board[row][col] == null:
		board[row][col] = currentPlayer
	var button = get_child(1).get_child(cellIndex) # GridContainer is child 1
	button.text = currentPlayer
	button.disabled = true
	check_win()
	if not gameOver:
		currentPlayer = "O" if currentPlayer == "X" else "X"
		if currentPlayer == "O":
			ai_move()


func check_win():
    
	for i in range(3): # Check rows
		if board[i][0] == board[i][1] and board[i][1] == board[i][2] and board[i][0] != null:
			end_game(board[i][0])
			return
    
	for j in range(3): # Check columns
		if board[0][j] == board[1][j] and board[1][j] == board[2][j] and board[0][j] != null:
			end_game(board[0][j])
			return
    # Check diagonals
	if board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[0][0] != null:
		end_game(board[0][0])
		return
	if board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] != null:
		end_game(board[0][2])
		return
	# Check draw
	var is_draw = true
	for i in range(3):
		for j in range(3):
			if board[i][j] == null:
				is_draw = false
				break
		if not is_draw:
			break
	if is_draw:
		end_game("Draw")

func end_game(winner):

	gameOver = true
	print("Game Over! Winner: ", winner)
	# Add UI to display winner (e.g., a Label node)

func ai_move():
	
	var emptyCells = []
	for i in range(3):
		for j in range(3):
			if board[i][j] == null:
				emptyCells.append([i, j])
	if emptyCells.size() > 0:
		var randIndex = randi() % emptyCells.size()
		var cell = emptyCells[randIndex]
		board[cell[0]][cell[1]] = "O"
		var buttonIndex = cell[0] * 3 + cell[1]
		var button = get_child(1).get_child(buttonIndex)
		button.text = "O"
		button.disabled = true
		check_win()
		if not gameOver:
			currentPlayer = "X"