extends Node

@export var targets: Array[PackedScene]
@export var nextUp01 : Sprite2D
@export var nextUp02 : Sprite2D
@export var nextUp03 : Sprite2D

func _ready() -> void:
	var sce = targets.pick_random() as PackedScene
	var inst = sce.instantiate() as Sprite2D
	nextUp01.texture = inst.texture
	
	sce = targets.pick_random() as PackedScene
	inst = sce.instantiate() as Sprite2D
	nextUp02.texture = inst.texture
	
	sce = targets.pick_random() as PackedScene
	inst = sce.instantiate() as Sprite2D
	nextUp03.texture = inst.texture
