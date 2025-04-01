extends Node

signal health_change
signal laser_ammo_change
signal grenade_ammo_change

var laser_ammo = 20:
	set(value):
		laser_ammo = value
		laser_ammo_change.emit()
var grenade_ammo = 5:
	set(value):
		grenade_ammo = value
		grenade_ammo_change.emit()
var health = 50: 
	set(value):
		health = value
		health_change.emit()
