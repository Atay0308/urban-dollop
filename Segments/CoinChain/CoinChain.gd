extends Path2D
tool

export(int, 100) var coin_interval = 60 setget set_coin_interval
export(String, "Gold", "Silver", "Ruby") var coin_type = "Gold" setget set_coin_type

var coin = preload("res://Coins/Coin.tscn")

func _ready():
	if !Engine.editor_hint:
		spawn_coins()

func _draw():
	if Engine.editor_hint:
		# Only shown in the editor as indicator during design time. 
		var l = int(curve.get_baked_length())
		var c: Color
		match coin_type:
			"Gold": c = Color(1,1,0)
			"Silver": c = Color(0.8,0.8,0.8)
			"Ruby": c = Color(1,0,0)
		for i in range (0, l, coin_interval):
			draw_circle(curve.interpolate_baked(i), 8, c)

func set_coin_interval(new_value):
	coin_interval = new_value
	update()
	
func set_coin_type(new_value):
	coin_type = new_value
	update()

func spawn_coins():
	var l = int(curve.get_baked_length())	#bestimme die länge der kurve
	for i in range (0, l, coin_interval):	#für jeden punkt in der länge der kurve
		var spawn_position = curve.interpolate_baked(i)		#setz die position der coins am nächsten punkt in der kurve
		var c = coin.instance()					#mache eine instant des coins
		add_child(c)					
		c.position = spawn_position				#setze die position des coins an der des punktes in der kurve
