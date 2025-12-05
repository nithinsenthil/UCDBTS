class_name NPCFactory
extends Node

const _npc_scene: PackedScene = preload("res://Scenes/npc.tscn")


# TODO: add level-specific multipliers?
func new_npc() -> Character:
	var new_npc_node = _npc_scene.instantiate()
	get_tree().current_scene.add_child(new_npc_node)
	new_npc_node.set_owner(get_tree().current_scene)
	
	new_npc_node.get_node("Brain")._maximum_suspicion = \
		clampf (randfn(Brain.MEAN_MAX_SUS, Brain.STDEV_MAX_SUS),
			  	Brain.MIN_MAX_SUS,
			  	Brain.MAX_MAX_SUS
		)
	
	new_npc_node.get_node("Ears")._sensitivity = \
		clampf (randfn(Ears.MEAN_SENS, Ears.STDEV_SENS),
			  	Ears.MIN_SENS,
			  	Ears.MAX_SENS
		)
	
	new_npc_node.get_node("Eyes")._sensitivity = \
		clampf (randfn(Eyes.MEAN_SENS, Eyes.STDEV_SENS),
			  	Eyes.MIN_SENS,
			  	Eyes.MAX_SENS
		)
		
	new_npc_node.get_node("Locomotion")._tendency_to_wander = \
		clampf (randfn(Locomotion.MEAN_WANDER, Locomotion.STDEV_WANDER),
			  	Locomotion.MIN_WANDER,
			  	Locomotion.MAX_WANDER
		)
	
	return new_npc_node
