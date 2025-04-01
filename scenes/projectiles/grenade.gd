extends RigidBody2D

const speed = 750
const explosion_radius = 350
var explosion_active: bool = false

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entities")
		for target in targets:
			if "hit" in target and target.global_position.distance_to(global_position) < explosion_radius:
				target.hit()
		
