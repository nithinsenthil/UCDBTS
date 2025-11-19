class_name DebugLabel
extends Label

@onready var player:Player = %Player
@onready var camera:CameraOne = %Camera


func _process(_delta: float) -> void:
	global_position.x = player.global_position.x
	global_position.y = player.global_position.y - 200
	
	text = "Player position: %f, %f\nCamera position:%f, %f\nPlayer facing:%s\nCamera offset:%f,%f" % [player.global_position.x,
			player.global_position.y, camera.global_position.x, camera.global_position.y, 
			player.Facing.keys()[player._facing], camera.offset.x, camera.offset.y]
