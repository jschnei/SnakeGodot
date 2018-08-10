extends Node2D

export (float) var SPEED = 100

var SnakeCell = preload("res://SnakeCell.tscn") 

var is_game_over = false
var cells = []
# cells[0] is back
# cells[-1] is front

func _ready():
	var cell = SnakeCell.instance()
	cell.back_point = Vector2(50, 50)
	cell.front_point = Vector2(200, 50)
	add_child(cell)
	cell.connect("hit", self, "game_over")
	cells.append(cell)
	
	

func _process(delta):
	if is_game_over:
		return
	
	var dir = direction()
	var input_dir = dir
	if Input.is_action_pressed("ui_right"):
		input_dir = Vector2(1, 0)
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2(-1, 0)
	elif Input.is_action_pressed("ui_up"):
		input_dir = Vector2(0, -1)
	elif Input.is_action_pressed("ui_down"):
		input_dir = Vector2(0, 1)
	
	var dist = delta*SPEED
	
	if abs(dir.dot(input_dir)) < 1e-3:
		var new_cell = SnakeCell.instance()
		new_cell.back_point = cells[-1].front_point
		new_cell.front_point = new_cell.back_point + dist*input_dir
		add_child(new_cell)
		new_cell.connect("hit", self, "game_over")
		cells.append(new_cell)
	else:
		cells[-1].grow(dist)
	
	while dist > cells[0].length():
		dist -= cells[0].length()
		cells[0].queue_free()
		cells.pop_front()
	
	cells[0].shrink(dist)
	
func direction():
	return cells[-1].direction()

func game_over():
	if not is_game_over:
		print("oh no we lost")
		is_game_over = true