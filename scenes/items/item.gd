extends Area2D

var rotation_speed: int = 4
var available_types = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = available_types[randi()%len(available_types)]

var direction: Vector2
var distance: int = randi_range(150,250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1,0.3,0.6)
	elif type == 'grenade':
		$Sprite2D.modulate = Color(0.6,0.1,0.3)
	elif type == 'health':
		$Sprite2D.modulate = Color(0.3,0.6,0.1)
	
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"position",target_pos,0.5)
	tween.tween_property(self,"scale",Vector2(1,1),0.3).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
#	body.add_item(type)
	if type == 'health':
		Globals.health += 10
	elif type == 'laser':
		Globals.laser_ammo += 5
	elif type == 'grenade':
		Globals.grenade_ammo += 1
	queue_free()
