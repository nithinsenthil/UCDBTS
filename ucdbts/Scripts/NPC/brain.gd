class_name Brain
extends Node

const MAX_MAX_SUS: float = 100.0
const MIN_MAX_SUS: float = 50.0
const MEAN_MAX_SUS: float = 100.0
const STDEV_MAX_SUS: float = 10.0

var suspicion : float = 0.0
var _maximum_suspicion : float = INF


func _physics_process(_delta: float) -> void:
	if suspicion > _maximum_suspicion:
		signals.npc_caught_player.emit()
