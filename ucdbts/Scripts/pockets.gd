class_name Pockets
extends CanvasLayer

@onready var pockets_label:Label = $Label
@onready var player:Player = %Player


func _ready() -> void:
	update_label()


func update_label() -> void:
	#pockets_label.text = "Pockets: %d/%d\nTotal held: $%d" % [ResourceManager.get_num_held_bikes(), ResourceManager.get_max_pocket_size(), 
			#ResourceManager.get_pocket_value()]
	pockets_label.text = "Bikes: $%d" % [ResourceManager.get_pocket_value()]
