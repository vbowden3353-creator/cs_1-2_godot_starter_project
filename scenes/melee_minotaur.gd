extends CharacterBody2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

var in_range = false
var chasing = false
var attacking = false
var speed = 200.0
var health = 3
var facing
var direction = 0
@onready var player: CharacterBody2D = %Player
@onready var minotaur_animation: AnimatedSprite2D = $"minotaur animation"


func _ready():
	pass
	
func _process(delta):
	if in_range:
		pass
	
	elif chasing and !attacking:
		velocity = Vector2.ZERO
		direction = position.direction_to(player.position)
		
	elif !chasing and !attacking:
		pass
	
	if chasing == true:
		position += direction * speed * delta

func update_animation():
	pass
	if attacking:
		minotaur_animation.play("attack_right")
		print("minotaur attacking")
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
		chasing = false
		
func _on_melee_body_exited(body):
	if body.name == "Player":
		attacking = false
		
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
	if in_range:
		shoot(player)
	
func _on_ranged_body_exited(body):
	if body.name == "Player":
		in_range = false

func shoot(player):
	# TODO: Create a new projectile instance
	var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
	projectile_clone.global_position = position
	
	# TODO: Set projectile direction using facing variable
	projectile_clone.set_direction(player.position)
	
	# TODO: Add projectile to the game world
	get_tree().get_root().add_child(projectile_clone)
