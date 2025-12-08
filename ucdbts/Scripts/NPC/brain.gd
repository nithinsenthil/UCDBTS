class_name Brain
extends Node

const MAX_MAX_SUS: float = 100.0
const MIN_MAX_SUS: float = 50.0
const MEAN_MAX_SUS: float = 100.0
const STDEV_MAX_SUS: float = 10.0

var suspicion : float = 0.0
var _maximum_suspicion : float = INF

var _has_caught = false
var _has_questioned = false
var _has_exclaimed = false

@onready var _status : StatusSprite = get_node("../StatusSprite")


func _process(_delta: float) -> void:
	if not _has_questioned and suspicion > 0.3 * _maximum_suspicion:
		_status.show_question()
		_has_questioned = true
	if not _has_exclaimed and suspicion > 0.8 * _maximum_suspicion:
		_status.show_exclamation()
		_has_exclaimed = true


func _physics_process(_delta: float) -> void:
	if not ResourceManager.caught and suspicion > _maximum_suspicion:
		ResourceManager.caught = true
		print("You've been caught!")
		signals.npc_caught_player.emit(get_node(".."))
