extends Node

@export var targets: Array[PackedScene]
@export var nextUp01 : Sprite2D
@export var nextUp02 : Sprite2D
@export var nextUp03 : Sprite2D

var nextUp : Array[PackedScene]

func _ready() -> void:
	nextUp.push_back(targets.pick_random() as PackedScene)
	nextUp.push_back(targets.pick_random() as PackedScene)
	nextUp.push_back(targets.pick_random() as PackedScene)
	
	updatePreview()

func takeNextShape() -> PackedScene:
	var next = nextUp.pop_front() as PackedScene
	
	nextUp.push_back(targets.pick_random() as PackedScene)
	
	updatePreview()
	
	return next
	
func updatePreview() -> void:
	nextUp01.texture = (nextUp[0].instantiate() as Sprite2D).texture
	nextUp01.cancel_free()
	
	nextUp02.texture = (nextUp[1].instantiate() as Sprite2D).texture
	nextUp02.cancel_free()
	
	nextUp03.texture = (nextUp[2].instantiate() as Sprite2D).texture
	nextUp03.cancel_free()

func _input(event):
	if Input.is_action_pressed("leftclick"):
		takeNextShape()
