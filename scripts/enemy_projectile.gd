extends Area2D

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
	
