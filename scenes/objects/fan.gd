extends StaticBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += delta * 400
