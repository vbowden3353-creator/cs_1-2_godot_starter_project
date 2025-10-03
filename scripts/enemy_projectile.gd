extends Area2D

var direction
var Speed = 300

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body):
	pass
func _physics_process(_delta):
	position += direction * Speed * _delta
	
func set_direction(target):
	direction = position.direction_to(target)
	
