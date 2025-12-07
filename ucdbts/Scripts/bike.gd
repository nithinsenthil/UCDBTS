class_name Bike
extends StaticBody2D

enum Facing {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

# tier 1: sparkle
# tier 2: normal, no effect
# tier 3: rust
@export var tier:int = 1
@export var value:int = 100
@export var stealing_time:float = 5
@export var bike_texture: Texture2D
@export var facing = Facing.RIGHT
var steal_timer:float = 5
var stealing:bool = false
var _player:Player = interactions.player
var _position_calculated:bool = false
@onready var _progress_bar:ProgressBar = $StealingProgressBar
@onready var bike_sprite:Sprite2D = $BikeSprite
@onready var hitbox_shape = $BikeHitbox/HitboxShape
@onready var collision_shape = $CollisionShape2D
@onready var particle_sprite = $ParticleSprite

# TODO: clean this up (e.g. get rid of magic numbers)
func _ready() -> void:
	# Configure collision and hitbox shape based on direction.
	collision_shape.shape = collision_shape.shape.duplicate()
	hitbox_shape.shape = hitbox_shape.shape.duplicate()

	if facing == Facing.DOWN or facing == Facing.UP:
		collision_shape.shape.size.x = 40
		hitbox_shape.shape.size.x = 64
		if facing == Facing.DOWN:
			bike_sprite.region_rect.position.y = 20
		else:
			bike_sprite.region_rect.position.y = 40
	else:
		collision_shape.shape.size.x = 76
		hitbox_shape.shape.size.x = 96
		bike_sprite.region_rect.position.y = 0
	
	if facing == Facing.LEFT:
		bike_sprite.flip_h = true
	
	# Set texture of bike.
	bike_sprite.texture = bike_texture
	
	# Configure particle effect based on tier.
	if tier == 1:
		particle_sprite.play_sparkle()
	elif tier == 3:
		particle_sprite.play_rust(facing)
	

func _process(delta: float) -> void:
	if !stealing:
		return
		
	# Check if player stopped holding interact
	if Input.is_action_just_released("Interact"):
		steal_timer = stealing_time / _player.stealing_speed
		stealing = false
		_player.interacting = false
		_progress_bar.visible = false
		signals.interaction_done.emit()
		return
	
	# Increment timer and check if interaction is done
	steal_timer = move_toward(steal_timer, 0, delta)
	_progress_bar.value = (stealing_time / _player.stealing_speed) - steal_timer
	if steal_timer == 0:
		stealing = false
		_player.interacting = false
		_player.steal_bike(value)
		queue_free()


func interact() -> void:
	_player = interactions.player
	if _player.pockets_full:
		_player.enable_pockets_full_label()
		signals.interaction_done.emit()
		return
	# Reset timer and set stealing to true
	steal_timer = stealing_time / _player.stealing_speed
	stealing = true
	_player.interacting = true
	_progress_bar.max_value = stealing_time / _player.stealing_speed
	_progress_bar.value = 0
	if !_position_calculated:
		_progress_bar.rotation_degrees = 360 - rotation_degrees
		_progress_bar.position = _progress_bar.position.rotated(-rotation)
		_position_calculated = true
	_progress_bar.visible = true
	


func _on_bike_hitbox_body_entered(_body: Node2D) -> void:
	interactions.current_interaction_object = self


func _on_bike_hitbox_body_exited(_body: Node2D) -> void:
	interactions.current_interaction_object = null
	if stealing:
		steal_timer = stealing_time / _player.stealing_speed
		stealing = false
		_player.interacting = false
		_progress_bar.visible = false
	signals.interaction_done.emit()
