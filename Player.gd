extends CharacterBody2D


const SPEED = 150.0
const GRAVITY = 300.0
const JUMP = -150.0

func _process(delta):
	velocity.y += delta * GRAVITY
	var jumpMultiplier = min(max(inverse_lerp(-250.0, 15.0, position.y), 0.0), 1.0)
	var velMultiplier = 1.0 - min(max(inverse_lerp(0, JUMP, velocity.y), 0.0), 1.0)
	if Input.is_action_just_pressed("ui_select"):
		velocity.y += JUMP * jumpMultiplier * velMultiplier
	print(jumpMultiplier)
	velocity.x = SPEED
	move_and_slide()
