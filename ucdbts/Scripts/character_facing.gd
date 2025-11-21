extends AnimatedSprite2D


const direction_strings = {
	Character.Facing.DEFAULT: "front",
	Character.Facing.LEFT: "side",
	Character.Facing.RIGHT: "side",
	Character.Facing.UP: "back",
	Character.Facing.UP_LEFT: "side",
	Character.Facing.UP_RIGHT: "side",
	Character.Facing.DOWN: "front",
	Character.Facing.DOWN_LEFT: "side",
	Character.Facing.DOWN_RIGHT: "side",
}

const action_strings = {
	Character.Action.IDLE: "idle",
	Character.Action.WALK: "walk",
	Character.Action.RUN: "run",
}


func _ready():
	signals.sprite_change.connect(_on_sprite_change)


func _on_sprite_change(facing: Character.Facing, action: Character.Action) -> void:
	if (facing == Character.Facing.RIGHT
			or facing == Character.Facing.UP_RIGHT
			or facing == Character.Facing.DOWN_RIGHT):
		flip_h = true
	else:
		flip_h = false
	play(action_strings[action] + "_" + direction_strings[facing])
