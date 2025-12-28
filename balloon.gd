extends Node2D

var score_manager: ScoreManager = null
var sfx_player: SFXPlayer = null
@export var score_value := 10
@onready var AnimatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Bouyancy: float = randf_range(25, 100)
var velocity: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	var highAltFactor = clamp(inverse_lerp(Constants.MINHEIGHT, Constants.MAXHEIGHT, position.y), 0.0, 1.0) # Increases to 1.0 as height approaches MAXHEIGHT
	var lowAltFactor = 1.0 - highAltFactor # Increases to 1.0 as height approaches MINHEIGHT
	var lift = -(Constants.BALLOON_GRAVITY + Bouyancy)
	if velocity.y > 0:
		lift += -velocity.y
	lift *= lowAltFactor
	velocity.y += (Constants.BALLOON_GRAVITY + lift) * delta
	velocity.x = Constants.BALLOON_SPEED * lowAltFactor
	velocity.y *= Constants.BALLOON_DAMPING # dampen
	position += velocity * delta     

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if sfx_player:
		sfx_player.play_pop()
	if score_manager:
		score_manager.add(score_value)
	else:
		push_warning("Balloon popped without ScoreManager")
	AnimatedSprite.play("Pop")

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
