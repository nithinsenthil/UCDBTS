class_name NPCSprite
extends Sprite2D

@onready var animation_player = $AnimationPlayer

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

const num_spritesheets = 5


func _ready() -> void:
	set_spritesheet(randi() % num_spritesheets + 1)
	z_index = 3


func _on_sprite_change(facing: Character.Facing, action: Character.Action) -> void:
	if (facing == Character.Facing.RIGHT
			or facing == Character.Facing.UP_RIGHT
			or facing == Character.Facing.DOWN_RIGHT):
		flip_h = true
	else:
		flip_h = false
	animation_player.play(action_strings[action] + "_" + direction_strings[facing])


func set_spritesheet(npc_index: int) -> void:
	texture = load("res://Assets/character/npc%d_sheet.png" % [npc_index])
