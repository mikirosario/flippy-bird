extends "res://Scripts/damageable.gd"

@export var Animator : AnimatedSprite2D
const SPEED = 400.0 
const JUMP = -150.0
var frameCounter : int = 0
#const BOUNCE_FACTOR = 0.3
#const BOUNCE_THRESHOLD = 15.0 # Minimum bounce impact velocity

func _applyBehavior():
	#if frameCounter == 2:
		#### mueve hacia el jugador
		#position.move_toward($Player.position, 100) null ref Player :P
	frameCounter = (frameCounter + 1) % 3
	
	print("Frame Counter %s" % frameCounter)

func _process(delta):
	var highAltFactor = min(max(inverse_lerp(Globals.MINHEIGHT, Globals.MAXHEIGHT, position.y), 0.0), 1.0)	# Increases to 1.0 as height approaches MAXHEIGHT
	var lowAltFactor = 1.0 - highAltFactor													# Increases to 1.0 as height approaches MINHEIGHT
	# print ("Vel Multiplier: %s" % velMultiplier)
	# print ("Post-Jump Velocity: %s" % velocity.y)
	velocity.x = SPEED * lowAltFactor
	Animator.speed_scale = highAltFactor + 0.2
	_applyBehavior()
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
