class_name Character
extends CharacterBody2D

# Enum numbers assigned for arithmetic purposes (add horizontal and vertical
# directions to get final direction eg. LEFT + UP = 4 = UP_LEFT
enum Facing {
	DEFAULT = 0,
	LEFT = 1,
	RIGHT = 2,
	UP = 3,
	UP_LEFT = 4,
	UP_RIGHT = 5,
	DOWN = 6,
	DOWN_LEFT = 7,
	DOWN_RIGHT = 8,
}

enum Action {
	IDLE = 0,
	WALK = 1,
	RUN = 2,
}

const DEFAULT_MOVE_VELOCITY = 150

@export var movement_speed = DEFAULT_MOVE_VELOCITY
var _facing:Facing = Facing.DOWN
var _action:Action = Action.IDLE


func _ready() -> void:
	change_facing(_facing)


func _physics_process(_delta: float) -> void:
	move_and_slide()


func change_facing(new_facing:Facing) -> void:
	_facing = new_facing
	#signals.sprite_change.emit(_facing, _action)


func change_action(new_action: Action) -> void:
	_action = new_action
	signals.sprite_change.emit(_facing, _action)
