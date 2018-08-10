extends Area2D

signal hit

export (float) var WIDTH
export (float) var COLLIDE_MARGIN

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
	
	var left = min(back_point.x, front_point.x) 
	var right = max(back_point.x, front_point.x)
	var up = min(back_point.y, front_point.y)
	var down = max(back_point.y, front_point.y)
	
	"""
	$Polygon2D.polygon = [Vector2(left - WIDTH/2, up - WIDTH/2),
						 Vector2(left - WIDTH/2, down + WIDTH/2),
						 Vector2(right + WIDTH/2, down + WIDTH/2),
						 Vector2(right + WIDTH/2, up - WIDTH/2)]
	"""

	$CollisionShape2D.shape.points = [Vector2(left + COLLIDE_MARGIN/2, up + COLLIDE_MARGIN/2),
						 			  Vector2(left + COLLIDE_MARGIN/2, down - COLLIDE_MARGIN/2),
						 			  Vector2(right - COLLIDE_MARGIN/2, down - COLLIDE_MARGIN/2),
						 			  Vector2(right - COLLIDE_MARGIN/2, up + COLLIDE_MARGIN/2)]
	
	print(shape_owner_get_shape(0, 0))
	$Polygon2D.polygon = $CollisionShape2D.shape.points
	
func grow(dist):
	# front point to move forward dist
	front_point = front_point + dist*direction()
	update_size()
	
func shrink(dist):
	# back point to move forward dist
	back_point = back_point + dist*direction()
	update_size()
	
func direction():
	return (front_point - back_point).normalized()
	
func length():
	return (front_point - back_point).length()
	
	
func _on_SnakeCell_area_entered(area):
	emit_signal("hit")
	pass # replace with function body
