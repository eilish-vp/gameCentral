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
