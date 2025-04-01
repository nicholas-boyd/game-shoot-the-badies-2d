extends CharacterBody2D

var active: bool = false
var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1

var vulnerable: bool = true
var health: int = 50

var exploding: bool = false

func _ready():
	$Explosion.hide()
	$DroneImage.show()

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			exploding = true
	if exploding:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entities")
		for target in targets:
			if "hit" in target and target.global_position.distance_to(global_position) < 400:
				target.hit()

func stop_movement():
	speed_multiplier = 0

func hit():
	if vulnerable:
		vulnerable = false
		health -= 10
		$HitTimer.start()
		$DroneImage.material.set_shader_parameter("progress",1)
	if health <= 0:
		$AnimationPlayer.play("explosion")
		exploding = true


func _on_notice_area_body_entered(body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout():
	vulnerable = true
	$DroneImage.material.set_shader_parameter("progress",0)
