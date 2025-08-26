# VisualCircle.gd
extends Control  # Supports _draw() and update()

var radius: float = 50.0

func _ready():
	queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, radius, Color(1, 0, 0, 0.4))
