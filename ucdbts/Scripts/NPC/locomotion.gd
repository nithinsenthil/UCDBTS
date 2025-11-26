class_name Locomotion
extends Node2D

var _tendency_to_wander : float = 1.0

@onready var _npc : CharacterBody2D = $".."
@onready var _nav_agent : NavigationAgent2D = $NavigationAgent2D


# Code adapted from https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html
func _ready():
	_nav_agent.path_desired_distance = 5.0 * (1 + _tendency_to_wander)
	_nav_agent.target_desired_distance = 3.0 * (1 + _tendency_to_wander)
	
	_nav_agent.connect("velocity_computed", _on_navigation_agent_2d_velocity_computed)
	
	# Wait for NavigationServer to come up
	actor_setup.call_deferred()


func actor_setup():
	# Wait for NavigationServer to come up
	await get_tree().physics_frame
	# TODO: initial movement logic
	set_movement_target(Vector2.ZERO)


func set_movement_target(target: Vector2):
	_nav_agent.target_position = target


func _physics_process(_delta):
	if _nav_agent.is_navigation_finished():
		# TODO: get rational next position
		set_movement_target((_nav_agent.target_position + Vector2(randf_range(-8, 8), randf_range(-8, 8))))
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = _nav_agent.get_next_path_position()

	var raw_velocity = current_agent_position.direction_to(next_path_position) * _npc.movement_speed
	_nav_agent.set_velocity(raw_velocity)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	_npc.set_velocity(safe_velocity)
