class_name Player
extends Character

var interacting:bool = false


func _ready() -> void:
	movement_speed = 200


func _physics_process(delta: float) -> void:
	# Get input direction
	var input_dir = Vector2(
	Input.get_action_strength("Right") - Input.get_action_strength("Left"),
	Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).limit_length(1.0)
	
	# Normalize input direction (magnitude of direction is 1)
	var direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	
	# Change velocity
	if direction:
		velocity.x = direction.x * movement_speed
		velocity.y = direction.y * movement_speed
		
		var horizontal_direction:Facing = Facing.DEFAULT
		var vertical_direction:Facing = Facing.DEFAULT
		
		# Change player facing direction
		if velocity.x > 0:
			horizontal_direction = Facing.RIGHT
		elif velocity.x < 0:
			horizontal_direction = Facing.LEFT
		if velocity.y < 0:
			vertical_direction = Facing.UP
		elif velocity.y > 0:
			vertical_direction = Facing.DOWN
		
		change_facing(horizontal_direction + vertical_direction as Facing)
		change_action(Action.RUN)
		
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		velocity.y = move_toward(velocity.y, 0, movement_speed)
		change_action(Action.IDLE)
	
	super(delta)
