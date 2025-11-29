class_name NPCDebugLabel
extends Label

var _brain : Brain


func _ready() -> void:
	_brain = $"../Brain"


func _process(_delta: float) -> void:
	text = "sus: " + str(roundf(_brain.suspicion))
