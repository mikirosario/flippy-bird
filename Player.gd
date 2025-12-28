extends CharacterBody2D

@export var Animator : AnimatedSprite2D

func _physics_process(delta):
	var velMultiplier = 1.0 - clamp(inverse_lerp(0, Constants.PLAYER_JUMP, velocity.y), 0.0, 1.0) # Decreases to 0 as velocity.y approaches Constants.PLAYER_JUMP, 1 at or above 0
	var highAltFactor = clamp(inverse_lerp(Constants.MINHEIGHT, Constants.MAXHEIGHT, position.y), 0.0, 1.0) # Increases to 1.0 as height approaches MAXHEIGHT
	var lowAltFactor = 1.0 - highAltFactor # Increases to 1.0 as height approaches MINHEIGHT
	var lift = -Constants.PLAYER_GRAVITY
	if velocity.y > 0:
		lift += -velocity.y
	lift *= lowAltFactor
	velocity.y += (Constants.PLAYER_GRAVITY + lift) * delta
	#print("Gravity + Lift: %s + %s" % [Constants.PLAYER_GRAVITY, lift])
	#print("HighAltFactor: %s" % highAltFactor)
	#print("LowAltFactor: %s" % lowAltFactor)
	#print("Vel: %s" % velocity.y)
	if Input.is_action_just_pressed("ui_select"):
		velocity.y += Constants.PLAYER_JUMP * lowAltFactor * velMultiplier
	#print ("Vel Multiplier: %s" % velMultiplier)
	#print ("Post-Jump Velocity: %s" % velocity.y)
	velocity.x = Constants.PLAYER_SPEED * lowAltFactor
	if abs(velocity.y) < 0.005:
		velocity.y = 0.0
	Animator.speed_scale = highAltFactor + 0.2
	move_and_slide()
