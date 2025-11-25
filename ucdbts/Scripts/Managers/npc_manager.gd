class_name NPCManager
extends Node

# TODO: Store specific level or spawn points (when that structure is more clear)
@onready var current_level: Node = get_tree().get_root()

const _npc_scene: PackedScene = preload("res://Scenes/npc.tscn")


func _ready() -> void:
	signals.spawn_npc.connect(_spawn_npc)
	# TODO: Set level to level_manager.get_level()


func _spawn_npc() -> void:
	# TODO: Use spawn points instead
	var new_npc_node: Character = _npc_scene.instantiate()
	current_level.add_child(new_npc_node)
	new_npc_node.set_owner(current_level)


# Debug NPC Spawning TODO: remove
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("SpawnNPC"):
		_spawn_npc()
