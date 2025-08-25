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
	var nu01 = nextUp[0].instantiate()
	nextUp01.texture = (nu01.get_node("Shape2D") as Sprite2D).texture
	nextUp01.cancel_free()
	
	var nu02 = nextUp[1].instantiate()
	nextUp02.texture = (nu02.get_node("Shape2D") as Sprite2D).texture
	nextUp02.cancel_free()
	
	var nu03 = nextUp[2].instantiate()
	nextUp03.texture = (nu03.get_node("Shape2D") as Sprite2D).texture
	nextUp03.cancel_free()
