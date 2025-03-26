extends CharacterBody2D


const SPEED = 300.0


func _process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2.RIGHT
	velocity = direction * SPEED

	move_and_slide()

func hit():
	print("damage")
