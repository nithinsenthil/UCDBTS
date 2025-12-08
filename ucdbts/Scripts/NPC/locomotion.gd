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
	
	var horizontal_direction:Character.Facing = Character.Facing.DEFAULT
	var vertical_direction:Character.Facing = Character.Facing.DEFAULT
	
	# Change NPC facing direction
	if safe_velocity.x > 0:
		horizontal_direction = Character.Facing.RIGHT
	elif safe_velocity.x < 0:
		horizontal_direction = Character.Facing.LEFT
	if safe_velocity.y < 0:
		vertical_direction = Character.Facing.UP
	elif safe_velocity.y > 0:
		vertical_direction = Character.Facing.DOWN
	
	var animation : NPCFacing = get_node("../AnimatedSprite2D")
	animation._on_sprite_change(
		horizontal_direction + vertical_direction as Character.Facing,
		Character.Action.IDLE \
			if safe_velocity.distance_squared_to(Vector2.ZERO) < 1000
			else Character.Action.RUN
	)
