class_name Bike
extends StaticBody2D

enum Facing {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

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
@onready var sprite2d:Sprite2D = $Sprite2D
@onready var hitbox_shape = $BikeHitbox/HitboxShape
@onready var collision_shape = $CollisionShape2D

# TODO: clean this up (e.g. get rid of magic numbers)
func _ready() -> void:
	collision_shape.shape = collision_shape.shape.duplicate()
	hitbox_shape.shape = hitbox_shape.shape.duplicate()

	if facing == Facing.DOWN or facing == Facing.UP:
		collision_shape.shape.size.x = 60
		hitbox_shape.shape.size.x = 96
		if facing == Facing.DOWN:
			sprite2d.region_rect.position.y = 20
		else:
			sprite2d.region_rect.position.y = 40
	else:
		collision_shape.shape.size.x = 112
		hitbox_shape.shape.size.x = 144
		sprite2d.region_rect.position.y = 0
	
	if facing == Facing.LEFT:
		sprite2d.flip_h = true
	
	sprite2d.texture = bike_texture
	

func _process(delta: float) -> void:
	if !stealing:
		return
		
	# Check if player stopped holding interact
	if Input.is_action_just_released("Interact"):
		steal_timer = stealing_time
		stealing = false
		_player.interacting = false
		_progress_bar.visible = false
		signals.interaction_done.emit()
		return
	
	# Increment timer and check if interaction is done
	steal_timer = move_toward(steal_timer, 0, delta)
	_progress_bar.value = stealing_time - steal_timer
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
	steal_timer = stealing_time
	stealing = true
	_player.interacting = true
	_progress_bar.max_value = stealing_time
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
		steal_timer = stealing_time
		stealing = false
		_player.interacting = false
		_progress_bar.visible = false
	signals.interaction_done.emit()
