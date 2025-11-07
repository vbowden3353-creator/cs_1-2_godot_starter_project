extends CharacterBody2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

var in_range = false
var chasing = false
var attacking = false
var speed = 200.0
var health = 3
var facing
var direction = 0
var timer = start_time
var start_time = 3
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
		position += direction * delta * speed
	
	if in_range:
		timer -= delta
		
	if timer < 0:
		shoot(player)
		timer = start_time
		
	if position.x > 0:
		facing = "right"
		
	elif position.x < 0:
		facing = "left"

func update_animation():
	pass
	if attacking:
		minotaur_animation.play("attack_right")
		print("minotaur attacking")
	elif chasing:
		minotaur_animation.play("attack_")
		
	elif in_range:
		minotaur_animation.play("crossbow_")

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
