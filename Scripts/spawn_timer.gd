extends Timer

const WAITMIN : float = 0.5 # Minimum wait time in seconds
const WAITMAX : float = 2.0 # Maximum wait time in seconds

@export var OffscreenIndicator : PackedScene
@export var Enemies : Array[PackedScene]
@export var Player : CharacterBody2D
var PlayerCamera : Camera2D
var next_mob : Node
var indicator : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerCamera = Player.get_node("Camera2D")
	next_mob = get_next_mob()
	indicator = spawn_indicator(remap(next_mob.random_velocity, next_mob.INERTIA_MIN, next_mob.INERTIA_MAX, 0.1, 0.5))
	# start()

#func get_enemy_spawn_position(bounds : Rect2) -> Vector2:
	#return Vector2(bounds.end.x, Globals.MINHEIGHT)

func get_next_mob() -> Node:
	var mob = Enemies[0].instantiate()
	return mob

func spawn_indicator(next_mob_velocity : float) -> Node:
	var indicator = OffscreenIndicator.instantiate()
	print(next_mob_velocity)
	indicator.indicator_velocity = next_mob_velocity
	$CanvasLayer.add_child(indicator)
	return indicator

func _on_timeout() -> void:
	stop()
	print("SpawnEnemy")
	var spawn_mob = next_mob
	next_mob = get_next_mob()
	spawn_mob.position = Vector2(PlayerCamera.get_viewport_rect().size.x * 0.5 + Player.position.x, Globals.MINHEIGHT)
	add_child(spawn_mob)
	indicator.queue_free()
	indicator = spawn_indicator(remap(next_mob.random_velocity, next_mob.INERTIA_MIN, next_mob.INERTIA_MAX, 0.5, 0.1))
	wait_time = Globals.rng.randf_range(WAITMIN, WAITMAX)
	print("New Wait Time: %s" % wait_time)
	start()
