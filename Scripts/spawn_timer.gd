extends Timer

const WAITMIN : float = 0.5 # Minimum wait time in seconds
const WAITMAX : float = 2.0 # Maximum wait time in seconds

@export var Enemies : Array[PackedScene]
@export var Player : CharacterBody2D
var PlayerCamera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerCamera = Player.get_node("Camera2D")
	_on_timeout()

#func get_enemy_spawn_position(bounds : Rect2) -> Vector2:
	#return Vector2(bounds.end.x, Globals.MINHEIGHT)

func _on_timeout() -> void:
	stop()
	print("SpawnEnemy")
	var mob = Enemies[0].instantiate()
	mob.position = Vector2(PlayerCamera.get_viewport_rect().size.x * 0.5 + Player.position.x, Globals.MINHEIGHT)
	add_child(mob)
	wait_time = Globals.rng.randf_range(WAITMIN, WAITMAX)
	print("New Wait Time: %s" % wait_time)
	start()
