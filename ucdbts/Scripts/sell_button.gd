extends Button

var player:Player = interactions.player

func _ready() -> void:
	text = "Sell bikes\nTotal value: %d" % [player.total_value]
	pass # Replace with function body.
