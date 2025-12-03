class_name CameraController
extends Camera2D

@export var _target:Character
var camera_name: String

func _ready() -> void:
	global_position = _target.global_position
