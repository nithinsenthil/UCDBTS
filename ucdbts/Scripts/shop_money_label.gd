extends Label

var player:Player = interactions.player


func _ready() -> void:
	text = "$%d" % [player.get_money()]
