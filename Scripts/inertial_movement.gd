extends "res://Scripts/damageable.gd"

const GRAVITY = 300.0
const INERTIA_MIN = -50
const INERTIA_MAX = -400

var random_velocity : int

func _init():
	random_velocity = Globals.rng.randi_range(INERTIA_MIN, INERTIA_MAX)

func _ready():
	velocity.y += random_velocity

func _process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
