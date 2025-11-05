extends Area2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

var direction
var Speed = 300
var body
var player

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	pass
	if body.name == "Player":
		body.change_health(-2)
		queue_free()
	
func _physics_process(_delta):
	position += direction * Speed * _delta
	
func set_direction(target):
	direction = position.direction_to(target)
	if direction.x <0: print("togge to the left")
	scale.x = -1
	
func shoot(body):
	# TODO: Create a new projectile instance
	var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
	projectile_clone.global_position = position
	
	# TODO: Set projectile direction using facing variable
	projectile_clone.set_direction(body.position)
	
	# TODO: Add projectile to the game world
	get_tree().get_root().add_child(projectile_clone)

	pass
