extends Node

signal health_change
signal laser_ammo_change
signal grenade_ammo_change

var player_pos: Vector2
var player_vulnerable: bool = true
var player_hit_sound: AudioStreamPlayer2D

var health = 50: 
	set(value):
		# Always allow player to recover health, and cap it at 100
		if value > health:
			health = min(value, 100)
		else: # If vulnerable, damage player and start invulnerability timer
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
				player_hit_sound.play()
		health_change.emit()
		
var laser_ammo = 20:
	set(value):
		laser_ammo = value
		laser_ammo_change.emit()
		
var grenade_ammo = 5:
	set(value):
		grenade_ammo = value
		grenade_ammo_change.emit()

func player_invulnerable_timer() -> void:
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
