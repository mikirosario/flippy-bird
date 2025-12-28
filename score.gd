extends Label

@export var score_manager: ScoreManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_manager.score_changed.connect(_on_score_changed)

func _on_score_changed(new_score: int):
	text = "SCORE: %d" % new_score
