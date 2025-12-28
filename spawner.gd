extends Node2D

@export var balloon_scene: PackedScene
@export var player_path: NodePath
@export var score_manager: ScoreManager

@export var max_balloons := 4
@export var spawn_ahead_min := 200.0
@export var spawn_ahead_max := 300.0
@export var spawn_y_min := -200.0
@export var spawn_y_max := 120.0

var player: Node2D
var active_balloons := 0

func _ready():
	player = get_node(player_path)

func _process(_delta):
	while active_balloons < max_balloons:
		spawn_balloon()
	for balloon in get_children():
		var dx = balloon.global_position.x - player.global_position.x
		if abs(dx) > spawn_ahead_max + 50:
			balloon.queue_free()

func spawn_balloon():
	var balloon = balloon_scene.instantiate()
	balloon.score_manager = score_manager
	var x_offset = randf_range(spawn_ahead_min, spawn_ahead_max)
	var y = randf_range(spawn_y_min, spawn_y_max)

	balloon.position = Vector2(
		player.global_position.x + x_offset,
		y
	)

	add_child(balloon)
	active_balloons += 1

	# Cleanup callback
	balloon.tree_exited.connect(_on_balloon_removed)

func _on_balloon_removed():
	active_balloons -= 1
