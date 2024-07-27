extends CharacterBody2D


const SPEED = 400.0 
const GRAVITY = 300.0
const LIFT = -300.0
const JUMP = -150.0
const MAXHEIGHT = -250.0
const MINHEIGHT = 135
const BOUNCE_FACTOR = 0.3
const BOUNCE_THRESHOLD = 15.0 # Minimum bounce impact velocity

func _process(delta):
	var jumpMultiplier = min(max(inverse_lerp(MAXHEIGHT, 15.0, position.y), 0.0), 1.0)	# Decreases to 0 as height approaches MAXHEIGHT
	var velMultiplier = 1.0 - min(max(inverse_lerp(0, JUMP, velocity.y), 0.0), 1.0)		# Decreases to 0 as velocity.y approaches JUMP
	var heightFactor = min(max(inverse_lerp(MINHEIGHT, MAXHEIGHT, position.y), 0.0), 1.0)
	var speedMultiplier = 1.0 - heightFactor # Slow down the higher you get
	var liftMultiplier = LIFT * speedMultiplier # Counteract gravity more the lower and faster you get
	velocity.y += (GRAVITY + liftMultiplier) * delta
	print("SpeedMult: %s" % speedMultiplier)
	print("LiftMult: %s" % liftMultiplier)
	print("Vel: %s" % velocity.y)
	if Input.is_action_just_pressed("ui_select"):
		velocity.y += JUMP * jumpMultiplier * velMultiplier
	print("Jump Multiplier: %s" % jumpMultiplier)
	print ("Vel Multiplier: %s" % velMultiplier)
	print ("Post-Jump Velocity: %s" % velocity.y)
	velocity.x = SPEED * speedMultiplier
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision and _collided_with_clouds(collision):
		velocity = velocity.slide(collision.get_normal())

func _collided_with_clouds(collision : KinematicCollision2D) -> bool:
	var impact_velocity = abs(velocity.dot(collision.get_normal()))
	return collision.get_collider().is_in_group("clouds") and impact_velocity > BOUNCE_THRESHOLD

func _bounce_off_clouds(collision : KinematicCollision2D) -> Vector2:
	return velocity.bounce(collision.get_normal()) * BOUNCE_FACTOR
