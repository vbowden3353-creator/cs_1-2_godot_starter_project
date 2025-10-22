extends Node
class_name minotaur

var maxHealth = 100
var health = maxHealth

func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Health: ", health)
