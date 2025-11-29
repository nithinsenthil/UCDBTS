class_name Brain
extends Node

var suspicion : float = 0.0
var _maximum_suspicion : float = INF


func _physics_process(_delta: float) -> void:
	if suspicion > _maximum_suspicion:
		signals.npc_caught_player.emit()
