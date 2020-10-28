extends Node2D


var coin = preload("res://Coins/Coin2.tscn")
var segments = [
	preload("res://Segments/CurlyChains.tscn"),
	preload("res://Segments/FilledRect.tscn"),
	preload("res://Segments/Circle.tscn")]
	
onready var player = $Player
var height_left = 0
var height_right = 0
var new_coin 
var neuer_coin
var coin_list = []
var height = 0
var coins = 0
var target_number_of_coins = 50
var get_magnet = false

func _ready():
	randomize()
	init_level()
	coins_straight_up_left()
#	coins_straight_up_middle()
	coins_straight_up_right()
#	for i in range(800):
#		var width = get_viewport_rect().size.x
#		new_coin = coin.instance()
#		new_coin.position = Vector2(rand_range(-width/2,width/2),height)
#		height -= rand_range(10,300)
#		add_child(new_coin)
#		var breite = get_viewport_rect().size.x
#		var hoehe = get_viewport_rect().size.y
#		neuer_coin = coin.instance()
#		height -= rand_range(10,100)
#		coin_list.append(neuer_coin)
#		for c in coin_list:
#			c.position = Vector2(rand_range(-breite/2,breite/2),hoehe)
#			hoehe -= rand_range(10,100)
#			height -= rand_range(10,100)
#			$Node.add_child(neuer_coin)
	
func coins_straight_up_left():
	for i in range(10):
		var width = get_viewport_rect().size.x
		new_coin = coin.instance()
		var half_width = (-width/2 +50)
		new_coin.position = Vector2(half_width,height_left)
		height_left -= 100
		$Node.add_child(new_coin,true)

func coins_straight_up_right():
	for i in range(10):
		var width = get_viewport_rect().size.x
		new_coin = coin.instance()
		var half_width = (width/2 - 50)
		new_coin.position = Vector2(half_width,height_right)
		height_right -= 100
		$Node.add_child(new_coin,true)
		
func coins_straight_up_middle():
	for i in range(10):
		var width = get_viewport_rect().size.x
		new_coin = coin.instance()
		var half_width = (width/2 - 50)
		new_coin.position = Vector2(rand_range(-half_width,half_width),0)
		
		$Node.add_child(new_coin,true)


func _process(delta):
	check_coins_for_deletion()
	if player.motion.y >= 2000:
		print("Lost")
#	become_magnetic()

func check_coins_for_deletion():
	for child in $Node.get_children():
		if child.position.y > player.position.y + 1000:
			child.queue_free()
					
					
					
func init_level():
	var s: CoinSegment
	var s_offset:float = 0
	var breite = get_viewport_rect().size.x
	for i in range(40):
		s = segments[randi() % segments.size()].instance()
		$Node.add_child(s,true)
		#s.position.y = s_offset
		s_offset -= s.segment_height
		s.position = Vector2(rand_range(-breite/2 -300,breite/2 - 300),s_offset)
		

func coins_up():
	coins += 1
	get_tree().call_group("GUI","update_coins",coins)
	var multiple_of_coins = (coins % target_number_of_coins) == 0
	if multiple_of_coins:
		player.boost()
		$AudioStreamPlayer2.play()

#func become_magnetic():
#	if get_magnet:
#		var bodies = $Area2D.get_overlapping_areas()
#		for body in bodies:
#			if body.name == player:
#				get_magnet = true
#				position = player.position
