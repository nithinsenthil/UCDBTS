class_name Locomotion
extends Node2D

const MAX_WANDER: float = 3.0
const MIN_WANDER: float = 0.0
const MEAN_WANDER: float = 2.0
const STDEV_WANDER: float = 0.67

const _DEFAULT_DESIRED_DISTANCE := 20.0
const _PATH_UPDATE_TIME := 0.5

var _tendency_to_wander : float = 2.0
var _update_timer : float = 0.0
var _noise : FastNoiseLite

@onready var _npc : CharacterBody2D = $".."
@onready var _nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var _brain : Brain = $"../Brain"


static func get_facing(vel: Vector2) -> Character.Facing:
	# Normalize movement direction (magnitude of direction is 1)
	var direction = (Vector2(vel.x, vel.y)).normalized()
	
	# Horizontal movement has higher magnitude than vertical movement
	var horiz_stronger = abs(direction.x) > abs(direction.y)
	
	var facing: Character.Facing = Character.Facing.DOWN
	
	# Change NPC facing direction
	if horiz_stronger:
		if direction.x > 0:
			facing = Character.Facing.RIGHT
		elif vel.x < 0:
			facing = Character.Facing.LEFT
	else:
		if vel.y < 0:
			facing = Character.Facing.UP
		elif vel.y > 0:
			facing = Character.Facing.DOWN
	
	return facing


# Code adapted from https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html
func _ready():
	_nav_agent.path_desired_distance = _DEFAULT_DESIRED_DISTANCE * (1 + _tendency_to_wander)
	_nav_agent.target_desired_distance = _DEFAULT_DESIRED_DISTANCE * (1 + _tendency_to_wander)
	
	_nav_agent.connect("velocity_computed", _on_navigation_agent_2d_velocity_computed)
	_nav_agent.max_speed = _npc.movement_speed
	
	# Set up noise source for wandering
	_noise = FastNoiseLite.new()
	_noise.seed = round(Time.get_unix_time_from_system())
	_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	_noise.frequency = 0.001
	
	# Wait for NavigationServer to come up
	actor_setup.call_deferred()


func actor_setup():
	# Wait for NavigationServer to come up
	await get_tree().physics_frame


func set_movement_target(target: Vector2):
	_nav_agent.target_position = target


func _physics_process(delta):
	_update_timer += delta
	if (_update_timer < _PATH_UPDATE_TIME):
		return
	else:
		_update_timer = 0.0
	
	if _nav_agent.is_navigation_finished():
		npc_manager._destroy_npc(_npc)
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = _nav_agent.get_next_path_position()

	var raw_velocity := current_agent_position.direction_to(next_path_position)
	raw_velocity *= _npc.movement_speed
	
	var angular_wander := 0.15 * PI * (_noise.get_noise_1d(Time.get_ticks_msec()) - 0.5)
	angular_wander *= _tendency_to_wander
	raw_velocity = raw_velocity.rotated(angular_wander)
	
	# Move the NPC towards the player. Scale with suspicion and npc velocity
	var suspicion_scalar = _brain.suspicion / _brain._maximum_suspicion
	var player_vector: Vector2 = (
		get_tree().current_scene.get_node("Player").global_position - global_position
	)
	player_vector = player_vector.normalized() * raw_velocity.distance_to(Vector2.ZERO)
	player_vector = player_vector * suspicion_scalar
	player_vector = player_vector * _tendency_to_wander / MEAN_WANDER
	raw_velocity += player_vector
	
	_nav_agent.set_velocity(raw_velocity)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	if not is_physics_processing():
		return
	
	_npc.set_velocity(safe_velocity)
	
	var facing := get_facing(safe_velocity)
	
	var animation : NPCSprite = get_node("../Sprite2D")
	animation._on_sprite_change(
		facing,
		Character.Action.IDLE \
			if safe_velocity.distance_squared_to(Vector2.ZERO) < 1000
			else Character.Action.WALK
	)
