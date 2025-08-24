extends Node2D

var objSpawned: bool = false
var objInstance = null
var objPos = null

func _ready() -> void:
	pass
	
func _input(event):
	
	if Input.is_action_pressed("leftclick") && objSpawned == false:
		var obj = load ("res://Nodes/SpawnableObject.tscn")
		objInstance = obj.instantiate()
		add_child(objInstance)
		objSpawned = true
		
	if Input.is_action_just_released("leftclick") && objSpawned == true:
		GameMessenger.objReleased.emit()
		objSpawned = false
