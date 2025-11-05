extends CharacterBody2D

var in_range = false
var chasing = false
var attacking = false
var speed = 200
var health = 3
var facing
@onready var player: CharacterBody2D = %Player
@onready var minotaur_animation: AnimatedSprite2D = $"minotaur animation"


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
		
func update_animation():
	pass
	if attacking:
		minotaur_animation.play("attack_right")
	else:
	# TODO: Set the animation based on the facing direction
		if velocity.is_zero_approx():
			minotaur_animation.play("idle_" + facing)
	# This combines "idle_" with whatever direction we're facing
		
		elif !velocity.is_zero_approx():
		#walking animation here
			minotaur_animation.play("walk_" + facing)

func _on_melee_body_entered(body):
	if body.name == "Player":
		attacking = true
		
func _on_melee_body_exited(body):
	if body.name == "Player":
		pass
		
func _on_chase_body_entered(body):
	if body.name == "Player":
		chasing = true
		in_range = false
	
func _on_chase_body_exited(body):
	if body.name == "Player":
		chasing = false
		in_range = true
		
func _on_ranged_body_entered(body):
	if body.name == "Player":
		in_range = true
	
func _on_ranged_body_exited(body):
	if body.name == "Player":
		in_range = false
