extends CharacterBody2D

signal laser_fired(pos, direction)
signal grenade_fired(pos, direction)
#signal update_stats

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
	if Input.is_action_pressed("primary_action") and can_laser and Globals.laser_ammo > 0:
		# Subtract an ammo, then randomly select a laser start position and pass to level via signal
		Globals.laser_ammo -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser_fired.emit(selected_laser.global_position, player_direction)
		
		# Start laser cooldown, and play laser particle effect
		can_laser = false
		$LaserTimer.start()
		$LaserEffect.restart()
		
		
	if Input.is_action_pressed("secondary_action") and can_grenade and Globals.grenade_ammo > 0:
		# Subtract an ammo, then choose the first start position (roughly centered) and pass to level via signal
		Globals.grenade_ammo -= 1
		var grenade_pos = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		grenade_fired.emit(grenade_pos, player_direction)
		$GrenadeTimer.start()


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true

#func add_item(type: String) -> void:
#	if type == 'laser':
#		Globals.laser_ammo += 5
#	elif type == 'grenade':
#		Globals.grenade_ammo += 1
#	update_stats.emit()
