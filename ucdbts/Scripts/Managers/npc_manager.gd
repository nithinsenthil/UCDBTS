class_name NPCManager
extends Node

var num_npcs : int = 0


func _ready() -> void:
	signals.spawn_npc.connect(_spawn_npc)


func _spawn_npc() -> void:
	var spawn_manager: SpawnManager = get_tree().current_scene.get_node("SpawnManager")
	var spawnpoints: Array[SpawnPoint] = spawn_manager.spawnpoints
	var new_position: Vector2 = spawnpoints.pick_random().global_position
	var new_target: Vector2 = spawnpoints.pick_random().global_position
	
	var new_npc_node: Character = npc_factory.new_npc()
	new_npc_node.global_position = new_position
	
	var npc_locomotion: Locomotion = new_npc_node.get_node("Locomotion")
	npc_locomotion.set_movement_target(new_target)
	
	num_npcs += 1


func _destroy_npc(npc: Character) -> void:
	npc.queue_free()
	num_npcs -= 1
