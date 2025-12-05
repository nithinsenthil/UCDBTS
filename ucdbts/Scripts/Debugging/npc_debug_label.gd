class_name NPCDebugLabel
extends Label

var _brain : Brain
var _eyes : Eyes
var _ears : Ears
var _locomotion : Locomotion


func _ready() -> void:
	_brain = $"../Brain"
	_eyes = $"../Eyes"
	_ears = $"../Ears"
	_locomotion = $"../Locomotion"


func _process(_delta: float) -> void:
	text = "sus: " + str(snappedf(_brain.suspicion, 0.1)) + "\n"
	text += "vision: " + str(snappedf(_eyes._sensitivity, 0.1)) + "\n"
	text += "hearing: " + str(snappedf(_ears._sensitivity, 0.1)) + "\n"
	text += "wandering: " + str(snappedf(_locomotion._tendency_to_wander, 0.1))
