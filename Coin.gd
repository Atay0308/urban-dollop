extends Node2D
onready var player = preload("res://Player/Player.tscn").instance()
var taken = false 
var get_magnet = true


func _on_Area2D_body_entered(body):
	if not taken:
		#$Particles2D.emitting = true
		taken = true
		get_tree().call_group("GameState","coins_up")
		$AnimationPlayer.play("die")
		if body.active:
			body.jump()
		#get_tree().get_root().get_node("TemplateLevel").get_node("AudioStreamPlayer2").play()
	
func die():
	queue_free()
	#$Particles2D.one_shot = true
	
func check_distance():
	if player.position.y > self.position.y + 300:
		queue_free()

func _physics_process(delta):
	become_magnetic()

func become_magnetic():
	if get_magnet:
		var bodies = $Area2D.get_overlapping_areas()
		for body in bodies:
			if body.name == "Area2D":
				print("hi")
				position += (get_tree().get_root().get_node("TemplateLevel").get_node("Player").position - position) / 25
				
