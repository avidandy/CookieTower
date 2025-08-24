extends RigidBody2D

@export var justSpawned: bool = false


func _ready() -> void:
	GameMessenger.connect("objReleased", dropObj)
	self.set_freeze_enabled(true)
	justSpawned = true
	
func _physics_process(delta: float) -> void:
	if justSpawned:
		objFollow()

func objFollow():
	self.position.y = 100
	var mouse_pos = get_viewport().get_mouse_position()
	self.position.x = self.position.lerp (mouse_pos, .1).x
	self.position.x = clamp (position.x, 80, (1152-80))
	
func dropObj():
	print("Drop")
	justSpawned = false	
	self.set_freeze_enabled(false)
