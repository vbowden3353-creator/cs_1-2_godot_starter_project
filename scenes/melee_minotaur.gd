extends CharacterBody2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

var in_range = false
var chasing = false
var attacking = false
var speed = 200.0
var health = 3
var facing
var direction = 0
var start_time = 3
var timer = start_time
var xDirection = 0
var yDirection = 0
@onready var player: CharacterBody2D = %Player
@onready var minotaur_animation: AnimatedSprite2D = $"minotaur animation"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	pass
	
func _process(delta):
	
	if player != null:
		if player.position.x < position.x:
			facing = "left"
			minotaur_animation.flip_h = true
		else:
			facing = "right"
			minotaur_animation.flip_h = false
	
	timer -= delta
	if in_range:
		if timer < 0:
			shoot(player)
			timer = start_time
	
	elif chasing :
		velocity = Vector2.ZERO
		direction = position.direction_to(player.position)
		position += direction * speed * delta
		
	elif attacking:
		pass
	
	#if xDirection > 0:
		#facing = "right"
	#elif xDirection < 0:
		#facing = "left"
#	elif yDirection < 0:
		#facing = "up"
	#elif yDirection > 0:
		#facing = "down"

	

func update_animation():
	pass
	if attacking:
		minotaur_animation.play("attack_right")
		print("minotaur attacking")
	elif chasing:
		minotaur_animation.play("crossbow_walk_" + direction)
		
	elif in_range:
		minotaur_animation.play("crossbow_shoot")
		

func _on_melee_body_entered(body):
	if body.name == "Player":
		attacking = true
		chasing = false
		
func _on_melee_body_exited(body):
	if body.name == "Player":
		attacking = false
		chasing = true
		
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
		player = body
		in_range = true
	
	
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
