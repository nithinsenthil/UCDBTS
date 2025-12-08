class_name Money
extends Node

#var _total_funds = 0
@onready var money_label: Label = $Label
@onready var player:Player = %Player



func _ready() -> void:
	# Initialize the label when the scene starts
	update_label()


func update_label() -> void:
	money_label.text = "Cash: $%d" % [ResourceManager.get_total_funds()]
