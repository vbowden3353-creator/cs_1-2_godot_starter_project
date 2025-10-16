extends Node
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var lever_original = preload("res://scenes/lever.tscn")

var on = false
var in_range = false
var player

func _process(_delta):
	if Input.is_action_just_pressed("ui_KEY_A"):
		in_range = true

update_animation()

if in_range == true
_animation_lever.play("on" + facing)

func on_body_entered(body):
	if body == "player":
		in_range = true
		
func update_animation():
		pass
