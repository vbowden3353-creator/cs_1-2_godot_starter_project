extends CharacterBody2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

var in_range = false
var chasing = false
var attacking = false
var speed = 100.0
var health = 3
var facing = "up"
var direction = 0
var start_time = 3
var timer = start_time
var xDirection = 0
var yDirection = 0
var start_attack_timer = 0.67
var melee_range
var attack_timer = start_attack_timer
var melee
var current_player

@onready var player: CharacterBody2D = %Player
@onready var minotaur_animation: AnimatedSprite2D = $"minotaur animation"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	pass
	
func _process(delta):
	
	if player != null:
		
	
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
			attack_timer -= delta
			if attack_timer <0:
				melee = false
				minotaur_animation.play("attack_" + facing)
				attack_timer = start_attack_timer
			if player != null:
				if player.has_method("change_health"):
					player.change_health(-1)
					print("has method")
				

	
		if abs (position.x - player.position.x) > abs (position.y - player.position.y):
			if position.x > player.position.x:
				facing = "right"
			else:
				facing = "left"
		else:		
			if position.y > player.position.y:
				facing = "up"
			else:
				facing = "down"
		if !attacking and !in_range and !chasing:
			minotaur_animation.play("idle_" + facing)
			
	
		update_animation()

func update_animation():
	pass
	if attacking:
		minotaur_animation.play("attack_" + facing)
		print("minotaur attacking")
	elif chasing:
		minotaur_animation.play("walk_" + facing)
		print("minotaur chasing")
		pass
		
	elif in_range:
		minotaur_animation.play("crossbow_shoot_" + facing)
		print("minotaur shooting")
		pass
		
	if !attacking and !in_range and !chasing:
		minotaur_animation.play("crossbow_idle_" + facing)


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
		in_range = true
	if in_range:
		shoot(player)
	if in_range:
		if player.position.x < position.x:
			minotaur_animation.flip_h = true
		else:
			minotaur_animation.flip_h = false
	
	
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
