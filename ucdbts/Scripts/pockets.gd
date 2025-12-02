class_name Pockets
extends CanvasLayer

@onready var pockets_label:Label = $Label
@onready var player:Player = %Player


func _ready() -> void:
	update_label()


func update_label() -> void:
	pockets_label.text = "Pockets: %d/%d\nTotal held: $%d" % [player.pockets.size(), player.pocket_size, 
			player.total_value]
