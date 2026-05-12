extends CharacterBody2D

@export var SPEED = 35.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$texture.flip_h = true if velocity.x < 0 else false
		$texture.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$texture.play("idle")

	move_and_slide()
