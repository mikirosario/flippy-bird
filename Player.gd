extends CharacterBody2D


const SPEED = 400.0
const GRAVITY = 300.0
const JUMP = -150.0
const MAXHEIGHT = -250.0

func _process(delta):
	velocity.y += delta * GRAVITY
	var jumpMultiplier = min(max(inverse_lerp(MAXHEIGHT, 15.0, position.y), 0.0), 1.0)	# Decreases to 0 as height approaches MAXHEIGHT
	var velMultiplier = 1.0 - min(max(inverse_lerp(0, JUMP, velocity.y), 0.0), 1.0)		# Decreases to 0 as velocity.y approaches JUMP
	if Input.is_action_just_pressed("ui_select"):
		velocity.y += JUMP * jumpMultiplier * velMultiplier
	#print("Jump Multiplier: %s" % jumpMultiplier)
	#print ("Vel Multiplier: %s" % velMultiplier)
	#print ("Vel Multiplier: %s" % velocity.y)
	velocity.x = SPEED
	move_and_slide()
