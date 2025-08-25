extends CollisionShape2D

var collAllowed: bool = true #prevents duplicated collision signals etc 

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("bonding") && collAllowed:
		GameMessenger.obj1 = self
		GameMessenger.obj2 = body
		GameMessenger.bondingCollision.emit()
		collAllowed = false
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.wait_time = .5
		timer.one_shot = true
		timer.timeout.connect(_on_timeout)
		timer.start()
		
func _on_timeout():
	collAllowed = true
	
