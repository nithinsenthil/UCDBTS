class_name Player
extends Character

var interacting:bool = false
var pockets:Array[int] = []
var pocket_size = 5
var pockets_full:bool = false
var pockets_full_indicator_on:bool = false
var total_value:int = 0
var label_timer:float = 2
var step_timer: Timer

var stealing_speed:float = 1

func _ready() -> void:
	movement_speed = 200
	interactions.player = self
	step_timer = Timer.new()
	step_timer.wait_time = 0.4
	step_timer.one_shot = true
	add_child(step_timer)
	ingest_stats()

	signals.npc_caught_player.connect(_on_player_caught)
	

func _physics_process(delta: float) -> void:
	get_node("../AudioManager").position = position
	
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
		
		if step_timer.is_stopped():
			signals.player_step.emit()
			step_timer.start()
		
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		velocity.y = move_toward(velocity.y, 0, movement_speed)
		change_action(Action.IDLE)
	
	if pockets_full_indicator_on:
		label_timer = move_toward(label_timer, 0, delta)
		if label_timer == 0:
			pockets_full_indicator_on = false
			$PocketsFullLabel.visible = false

	if interacting:
		var vm: float = 1.0
		var am: float = 1.0
		
		if ResourceManager._held_item:
			vm = ResourceManager._held_item.visual_suspicion_multiplier
			am = ResourceManager._held_item.audial_suspicion_multiplier
		
		signals.player_visually_sus.emit(global_position, vm)
		signals.player_audially_sus.emit(global_position, am)
	
	super(delta)
	

# func steal_bike(value:int) -> void:
# 	pockets.push_back(value)
# 	total_value += value
# 	if pockets.size() == pocket_size:
# 		pockets_full = true
# 	%PocketsDisplay.update_label()


func ingest_stats() -> void:
	movement_speed = ResourceManager.player_speed
	print(movement_speed)
	stealing_speed = ResourceManager.stealing_speed
	print(stealing_speed)


func enable_pockets_full_label() -> void:
	pockets_full_indicator_on = true
	$PocketsFullLabel.visible = true
	label_timer = 2


func _on_player_caught(_npc: Character) -> void:
	await get_tree().create_timer(2.0).timeout
	ResourceManager.wipe_resources()
	SceneManager.load_new_scene("res://Scenes/title.tscn", "fade_to_black")
