extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (float) var WIDTH

var back_point = Vector2(100, 0)
var front_point = Vector2(500, 0)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	update_size()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
	
func update_size():
	var is_horizontal = back_point.y == front_point.y
	var new_rectangle = []
	if is_horizontal:
		new_rectangle.append(Vector2(back_point.x, back_point.y-WIDTH/2))
		new_rectangle.append(Vector2(back_point.x, back_point.y+WIDTH/2))
		new_rectangle.append(Vector2(front_point.x, front_point.y+WIDTH/2))
		new_rectangle.append(Vector2(front_point.x, back_point.y-WIDTH/2))
	else:
		assert back_point.x == front_point.x
		new_rectangle.append(Vector2(back_point.x-WIDTH/2, back_point.y))
		new_rectangle.append(Vector2(back_point.x+WIDTH/2, back_point.y))
		new_rectangle.append(Vector2(front_point.x+WIDTH/2, front_point.y))
		new_rectangle.append(Vector2(front_point.x-WIDTH/2, front_point.y))
		
	$Polygon2D.polygon = new_rectangle
	$CollisionShape2D.shape.points = new_rectangle
	
