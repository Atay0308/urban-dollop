extends Camera2D
export(NodePath) var bg_path
var bg_size

export(NodePath) var player_path
var player

func _ready():
	player = get_node(player_path)
	bg_size = get_node(bg_path)
	#limit_top = bg_size.rect_size.y
	
func _process(delta):
	
	if player.position.y < position.y:
		position.y = player.position.y
	elif player.position.y > position.y:
		position.y = player.position.y 
	#elif player.position <= bg.size.y:
		
