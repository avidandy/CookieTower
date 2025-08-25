extends Node2D

var objSpawned: bool = false
var objInstance = null
var objPos = null

@export var nextUp : Node2D
	
func _ready() -> void:
	GameMessenger.connect("bondingCollision", bonding)

func bonding():
#	print(get_tree().get_nodes_in_group("bonding"))	
	if GameMessenger.obj1.get_position().y > GameMessenger.obj2.get_position().y:
		GameMessenger.obj1.queue_free()
		print("obj 1 is higher and should be deleted")
	else:
		GameMessenger.obj2.queue_free()
		print("obj 2 is higher and should be deleted")

	
func _input(event):
	
	if Input.is_action_pressed("leftclick") && objSpawned == false:
		var obj = nextUp.takeNextShape() as PackedScene
		objInstance = obj.instantiate()
		add_child(objInstance)
		objSpawned = true
		
	if Input.is_action_just_released("leftclick") && objSpawned == true:
		GameMessenger.objReleased.emit()
		objSpawned = false
