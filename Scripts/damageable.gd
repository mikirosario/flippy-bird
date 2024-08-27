extends CharacterBody2D

@export var HealthMin : int = 0
@export var HealthMax : int = 10

var Health : int = HealthMax :
	get:
		return Health
	set(value):
		Health = clamp(value, 0, HealthMax)

func addHealth(addend : int):
	Health += addend
