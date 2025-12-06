class_name SpawnManager
extends Node

# Set in the editor for each level
@export var spawnpoints : Array[SpawnPoint]
@export var max_num_npcs : int

var num_npcs : int = 0


func _physics_process(_delta: float) -> void:
	var spawn_manager: SpawnManager = get_tree().current_scene.get_node("SpawnManager")
	if (spawn_manager.num_npcs < max_num_npcs):
		npc_manager._spawn_npc()
