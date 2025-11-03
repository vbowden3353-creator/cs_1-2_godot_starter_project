extends CharacterBody2D

var in_range = false
var chasing = false
var attacking = false
var speed = 200
var health = 3
@onready var player: CharacterBody2D = %Player


func _ready():
	pass
	
func _process(delta):
	if in_range:
		pass
	elif chasing and !attacking:
		velocity = Vector2.ZERO
		if player:
			velocity = position.direction_to(player.position) * speed
			move_and_slide()
	elif chasing and attacking:
		pass
	elif !in_range and !chasing and !attacking:
		pass

func _on_melee_body_entered(body):
	if body.name == "Player":
		attacking = true
		
func _on_melee_body_exited(body):
	if body.name == "Player":
		pass
		
func _on_chase_body_entered(body):
	pass
	
func _on_chase_body_exited(body):
	if body.name == "Player":
		chasing = false
		in_range = true
		
func _on_DetectRadius_body_entered(body):
	player = body

func _on_DetectRadius_body_exited(body):
	player = null
