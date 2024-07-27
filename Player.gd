extends CharacterBody2D


const SPEED = 400.0
const GRAVITY = 300.0
const JUMP = -150.0
const MAXHEIGHT = -250.0
const BOUNCE_FACTOR = 0.8
const BOUNCE_THRESHOLD = 15.0 # Minimum bounce impact velocity

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
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var impact_velocity = abs(velocity.dot(collision.get_normal()))
		print(impact_velocity)
		if collision.get_collider().is_in_group("clouds") and impact_velocity > BOUNCE_THRESHOLD:
			velocity = velocity.bounce(collision.get_normal()) * BOUNCE_FACTOR
		else:
			velocity = velocity.slide(collision.get_normal())
	
