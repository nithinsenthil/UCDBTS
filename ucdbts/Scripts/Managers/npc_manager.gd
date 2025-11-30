class_name NPCManager
extends Node


func _ready() -> void:
	signals.spawn_npc.connect(_spawn_npc)
	# TODO: Set level to level_manager.get_level()


func _spawn_npc() -> void:
	# TODO: Use spawn points instead (set global_pos)
	var _new_npc_node: Character = npc_factory.new_npc()


# Debug NPC Spawning TODO: remove
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("SpawnNPC"):
		_spawn_npc()
