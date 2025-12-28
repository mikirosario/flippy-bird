extends Node2D
const SPEED = 375.0 
const MAXHEIGHT = -280.0
const MINHEIGHT = 165
const GRAVITY = 300.0

var score_manager: ScoreManager = null
var sfx_player: SFXPlayer = null
@export var score_value := 10
@onready var AnimatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Bouyancy: float = randf_range(25, 100)
var velocity: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	var highAltFactor = clamp(inverse_lerp(MINHEIGHT, MAXHEIGHT, position.y), 0.0, 1.0) # Increases to 1.0 as height approaches MAXHEIGHT
	var lowAltFactor = 1.0 - highAltFactor # Increases to 1.0 as height approaches MINHEIGHT
	var lift = -(GRAVITY + Bouyancy)
	if velocity.y > 0:
		lift += -velocity.y
	lift *= lowAltFactor
	velocity.y += (GRAVITY + lift) * delta
	velocity.x = SPEED * lowAltFactor
	# Animator.speed_scale = highAltFactor + 0.2
	# rotation_degrees
	velocity.y *= 0.96 # dampen
	position += velocity * delta     

func _on_area_2d_body_entered(body: Node2D) -> void:
	if sfx_player:
		sfx_player.play_pop()
	if score_manager:
		score_manager.add(score_value)
	else:
		push_warning("Balloon popped without ScoreManager")
	AnimatedSprite.play("Pop")

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
