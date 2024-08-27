extends "res://Scripts/damageable.gd"

@export var Animator : AnimatedSprite2D
const SPEED = 400.0 
const GRAVITY = 300.0
const JUMP = -150.0
const MAXHEIGHT = -280.0
const MINHEIGHT = 165
#const BOUNCE_FACTOR = 0.3
#const BOUNCE_THRESHOLD = 15.0 # Minimum bounce impact velocity

func _process(delta):
	var velMultiplier = 1.0 - min(max(inverse_lerp(0, JUMP, velocity.y), 0.0), 1.0)			# Decreases to 0 as velocity.y approaches JUMP, 1 at or above 0
	var highAltFactor = min(max(inverse_lerp(MINHEIGHT, MAXHEIGHT, position.y), 0.0), 1.0)	# Increases to 1.0 as height approaches MAXHEIGHT
	var lowAltFactor = 1.0 - highAltFactor													# Increases to 1.0 as height approaches MINHEIGHT
	var lift = -GRAVITY
	if velocity.y > 0:
		lift += -velocity.y
	lift *= lowAltFactor
	velocity.y += (GRAVITY + lift) * delta
	print("Gravity + Lift: %s + %s" % [GRAVITY, lift])
	print("HighAltFactor: %s" % highAltFactor)
	print("LowAltFactor: %s" % lowAltFactor)
	print("Vel: %s" % velocity.y)
	if Input.is_action_just_pressed("ui_select"):
		velocity.y += JUMP * lowAltFactor * velMultiplier
	print ("Vel Multiplier: %s" % velMultiplier)
	print ("Post-Jump Velocity: %s" % velocity.y)
	velocity.x = SPEED * lowAltFactor
	if abs(velocity.y) < 0.005:
		velocity.y = 0.0
	Animator.speed_scale = highAltFactor + 0.2
	# rotation_degrees
	move_and_slide()
	#var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	#if collision and _collided_with_clouds(collision):
		#velocity = velocity.slide(collision.get_normal())
#
#func _collided_with_clouds(collision : KinematicCollision2D) -> bool:
	#var impact_velocity = abs(velocity.dot(collision.get_normal()))
	#return collision.get_collider().is_in_group("clouds") and impact_velocity > BOUNCE_THRESHOLD
#
#func _bounce_off_clouds(collision : KinematicCollision2D) -> Vector2:
	#return velocity.bounce(collision.get_normal()) * BOUNCE_FACTOR
