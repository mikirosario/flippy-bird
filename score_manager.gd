extends Node
class_name ScoreManager

signal score_changed(new_score)

var score := 0

func add(points: int):
	score += points
	score_changed.emit(score)
