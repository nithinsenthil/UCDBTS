class_name CameraOne
extends CameraController


func _process(_delta: float) -> void:
	# target lock
	_move_camera()
	global_position = _target.global_position


# idea: allow the player to move the camera around, simulating "looking around"
# player can move camera up, down, left, and right
# use offset variable in Camera2D
func _move_camera() -> void:
	pass
