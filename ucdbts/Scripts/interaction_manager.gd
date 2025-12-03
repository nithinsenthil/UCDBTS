class_name InteractionManager
extends Node

var player:Player = null
var current_interaction_object = null
var interaction_enabled = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and interaction_enabled:
		if current_interaction_object == null:
			return
		interaction_enabled = false
		current_interaction_object.interact()
		await signals.interaction_done
		interaction_enabled = true
