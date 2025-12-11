class_name SpawnManager
extends Node

# Set in the editor for each level
@export var spawnpoints : Array[SpawnPoint]
@export var max_num_npcs : int

var num_npcs : int = 0

const _spawn_period:float = 0.5
var _spawn_timer: float = 0.0


func _ready() -> void:
	max_num_npcs = max_num_npcs + 10 * ResourceManager._current_level


func _physics_process(delta: float) -> void:
	_spawn_timer += delta
	
	if _spawn_timer > _spawn_period:
		_spawn_timer = 0.0
	else:
		return
	
	var spawn_manager: SpawnManager = get_tree().current_scene.get_node("SpawnManager")
	if (spawn_manager.num_npcs < max_num_npcs):
		npc_manager._spawn_npc()
