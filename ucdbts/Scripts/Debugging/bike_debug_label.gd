class_name BikeDebugLabel
extends Label

@onready var player:Player = interactions.player


func _process(_delta: float) -> void:
	player = interactions.player
	global_position = player.global_position + Vector2(0,50)
	text = ""
	for i in player.pockets:
		text += "%f " % i
