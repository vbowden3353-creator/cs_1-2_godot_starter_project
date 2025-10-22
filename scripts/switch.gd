extends Node
@onready var activation_range: CollisionShape2D = $Area2D/CollisionShape2D
@onready var animation_lever: AnimatedSprite2D = $AnimatedSprite2D
var lever_original = preload("res://scenes/lever.tscn")

var on = false
var in_range = false
@onready var player: CharacterBody2D = %Player


func _ready() -> void:
	animation_lever.play("off")
	on = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch") and in_range:
		print("switch pressed while in range")
		if name == "Lever":
			if !on:
				animation_lever.play("on")
				player.lever = true
				on = true
			else:
				animation_lever.play("off")
				player.lever = false
				on = false
		if name == "Lever2":
			if !on:
				animation_lever.play("on")
				player.lever2 = true
				on = true
			else:
				animation_lever.play("off")
				player.lever2 = false
				on = false
		if name == "Lever3":
			if !on:
				animation_lever.play("on")
				player.lever3 = true
				on = true
			else:
				animation_lever.play("off")
				player.lever3 = false
				on = false



func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		in_range = true
		



func _on_body_exited(body) -> void:
	if body.is_in_group("player"):
		in_range = false
