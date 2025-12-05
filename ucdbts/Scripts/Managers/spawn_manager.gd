class_name SpawnManager
extends Node

# Set in the editor for each level
@export var spawnpoints : Array[SpawnPoint]
@export var max_num_npcs : int


func _physics_process(_delta: float) -> void:
	if (npc_manager.num_npcs < max_num_npcs):
		npc_manager._spawn_npc()
