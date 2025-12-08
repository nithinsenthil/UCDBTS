class_name Locomotion
extends Node2D

const MAX_WANDER: float = 3.0
const MIN_WANDER: float = 0.0
const MEAN_WANDER: float = 2.0
const STDEV_WANDER: float = 0.67

const _DEFAULT_DESIRED_DISTANCE = 10.0

var _tendency_to_wander : float = 2.0

@onready var _npc : CharacterBody2D = $".."
@onready var _nav_agent : NavigationAgent2D = $NavigationAgent2D


# Code adapted from https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html
func _ready():
	_nav_agent.path_desired_distance = _DEFAULT_DESIRED_DISTANCE * (1 + _tendency_to_wander)
	_nav_agent.target_desired_distance = _DEFAULT_DESIRED_DISTANCE * (1 + _tendency_to_wander)
	
	_nav_agent.connect("velocity_computed", _on_navigation_agent_2d_velocity_computed)
	_nav_agent.max_speed = _npc.movement_speed
	
	# Wait for NavigationServer to come up
	actor_setup.call_deferred()


func actor_setup():
	# Wait for NavigationServer to come up
	await get_tree().physics_frame


func set_movement_target(target: Vector2):
	_nav_agent.target_position = target


func _physics_process(_delta):
	if _nav_agent.is_navigation_finished():
		npc_manager._destroy_npc(_npc)
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = _nav_agent.get_next_path_position()

	var raw_velocity = current_agent_position.direction_to(next_path_position)
	raw_velocity *= _npc.movement_speed
	_nav_agent.set_velocity(raw_velocity)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	_npc.set_velocity(safe_velocity)
	
	# Normalize movement direction (magnitude of direction is 1)
	var direction = (Vector2(safe_velocity.x, safe_velocity.y)).normalized()
	
	# Horizontal movement has higher magnitude than vertical movement
	var horiz_stronger = abs(direction.x) > abs(direction.y)
	
	var facing: Character.Facing = Character.Facing.DOWN
	
	# Change NPC facing direction
	if horiz_stronger:
		if direction.x > 0:
			facing = Character.Facing.RIGHT
		elif safe_velocity.x < 0:
			facing = Character.Facing.LEFT
	else:
		if safe_velocity.y < 0:
			facing = Character.Facing.UP
		elif safe_velocity.y > 0:
			facing = Character.Facing.DOWN
	
	var animation : NPCSprite = get_node("../Sprite2D")
	animation._on_sprite_change(
		facing,
		Character.Action.IDLE \
			if safe_velocity.distance_squared_to(Vector2.ZERO) < 1000
			else Character.Action.WALK
	)
