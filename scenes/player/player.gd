extends CharacterBody2D

signal laser_fired(pos, direction)
signal grenade_fired(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	# Get Input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# Rotate Player
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary_action") and can_laser:
		# Randomly select a laser start position, and pass to level via signal
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		laser_fired.emit(selected_laser.global_position, player_direction)
		$LaserTimer.start()
		$LaserEffect.restart()
		
	if Input.is_action_pressed("secondary_action") and can_grenade:
		# Choose the first start position (roughly centered), and pass to level via signal
		var grenade_pos = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		grenade_fired.emit(grenade_pos, player_direction)
		$GrenadeTimer.start()


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
