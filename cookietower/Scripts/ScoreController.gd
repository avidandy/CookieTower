extends Node

var score: int = 0

signal score_changed(score: int)

func increase_score(points: int):
	score += points
	emit_signal("score_changed", score)
	
func decrease_score(points: int):
	score -= points
	emit_signal("score_changed", score)

func reset_score():
	score = 0
	emit_signal("score_changed", score)
