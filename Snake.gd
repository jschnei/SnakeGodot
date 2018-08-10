extends Area2D

const SPEED = 100
var velocity = Vector2()



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = SPEED
		
	position.x += delta*velocity.x
	position.y += delta*velocity.y

