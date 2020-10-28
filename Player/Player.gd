extends KinematicBody2D

var motion = Vector2()
var speed = 100
var jump_speed = -1000
const FRICTION = 0.2
const MAX_SPEED = 900
const UP = Vector2(0,-1)
var GRAVITY = 20
var width
export(NodePath) var camera_path
var camera
var height
var active = true
onready var coin = load("res://Coins/Coin.tscn")

func _ready():
	camera = get_node(camera_path)
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y

func _physics_process(delta):
	move()
#	if position.y == -50000:
	apply_gravity()
#		motion.y = 0
#		print("Won")
	if motion.y >= -500:
		active = true
	#print(get_parent().get_magnet)
	
func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = clamp(motion.x - speed,-MAX_SPEED,0)
		$Sprite.flip_h = true
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = clamp(motion.x + speed,0,MAX_SPEED)
		$Sprite.flip_h = false
	else:
		motion.x = lerp(motion.x,0,FRICTION)
		
	if Input.is_action_pressed("jump"):
		motion.y = jump_speed
		
	move_and_slide(motion,UP)
	
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
		
	if motion.y > 0:							#rotate the bird 
		$Sprite.rotation_degrees = 30
		if $Sprite.flip_h == true:
			$Sprite.rotation_degrees = -30
	elif motion.y < 0:
		$Sprite.rotation_degrees = -30
		if $Sprite.flip_h == true:
			$Sprite.rotation_degrees = 30
	else:
		$Sprite.rotation_degrees = 0
		
func apply_gravity():
	if not is_on_floor():
		motion.y += GRAVITY
		
	if motion.y >= 2000:
		motion.y = 2000
	if motion.y <= -2000:
		motion.y = -2000
	
	
func jump():
	motion.y = jump_speed

func boost():
	motion.y = jump_speed * 2
	active = false
	
func _on_VisibilityNotifier2D_screen_exited():
	if position.x > camera.position.x:
		position.x = -width/2
	elif position.x < camera.position.x:
		position.x = width/2
	camera.position.y = camera.position.y


#func _on_Area2D_body_entered(body):
#	if body.name == "":
#		print("hi")
#		get_parent().get_magnet = true
