extends Node2D

var objSpawned: bool = false
var objInstance = null
var objPos = null

var picked_body: RigidBody2D
var joint: PinJoint2D
var mouse_body: StaticBody2D


@export var nextUp : Node2D
	
func _ready() -> void:
	GameMessenger.connect("bondingCollision", bonding)

func _physics_process(delta: float) -> void:
	if mouse_body:
		var target_pos = get_global_mouse_position()

		target_pos.x = clamp(target_pos.x, 290, 860)
		target_pos.y = clamp(target_pos.y, 100, 100)
		mouse_body.global_position = mouse_body.global_position.lerp(target_pos, 0.2)
		


func bonding():
#	print(get_tree().get_nodes_in_group("bonding"))	
	print("Collider 1 - ", GameMessenger.obj1.get_instance_id ( ), " | Y : ", GameMessenger.obj1.get_position().y)
	print("Collider 2 - ", GameMessenger.obj2.get_instance_id ( ), " | Y : ", GameMessenger.obj2.get_position().y)
	if GameMessenger.obj1.get_position().y < GameMessenger.obj2.get_position().y:
		apply_bond(GameMessenger.obj1)
		GameMessenger.obj1.queue_free()
		print("obj 1 is higher and should be deleted")
	else:
		apply_bond(GameMessenger.obj2)
		GameMessenger.obj2.queue_free()
		print("obj 2 is higher and should be deleted")


func apply_bond(object):
	var detection_area = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	
	circle_shape.radius = 150.0
	collision_shape.shape = circle_shape
	detection_area.add_child(collision_shape)
	
	# Instead of adding detection_area as a child of object,
	# add it to this node (or another persistent node)
	add_child(detection_area)
	detection_area.global_position = object.global_position
	
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	
	var debug_circle = preload("res://Scenes/debug_circle.gd").new()
	debug_circle.radius = 150.0
	detection_area.add_child(debug_circle)

	
func _input(event):
	
	if Input.is_action_pressed("leftclick") && objSpawned == false:
		_pick_body(event.position)

		
	if Input.is_action_just_released("leftclick") && objSpawned == true:
		_release_body()
		GameMessenger.objReleased.emit()
		objSpawned = false
		
func _pick_body(mouse_pos: Vector2) -> void:
	var obj = nextUp.takeNextShape() as PackedScene
	picked_body = obj.instantiate()
	picked_body.global_position = mouse_pos
	add_child(picked_body)
	objSpawned = true
	picked_body.gravity_scale = 0.0
	
	mouse_body = StaticBody2D.new()
	mouse_body.global_position = mouse_pos
	add_child(mouse_body)
	
	joint = PinJoint2D.new()
	joint.node_a = mouse_body.get_path()
	joint.node_b = picked_body.get_path()
	joint.global_position = mouse_pos
	add_child(joint)
	
func _release_body() -> void:
	picked_body.gravity_scale = 1
	if joint:
		joint.queue_free()
		joint = null
	if mouse_body:
		mouse_body.queue_free()
		mouse_body = null
	picked_body = null

func _on_body_entered(body):
	print("Body entered detection area: ", body.name)
	if body is RigidBody2D:
		body.set_deferred("freeze", true)
