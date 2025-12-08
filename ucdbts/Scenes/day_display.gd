class_name DayDisplay
extends Node

#var _total_funds = 0
@onready var day_label: Label = $Label


func _ready() -> void:
	# Initialize the label when the scene starts
	update_label()


func update_label() -> void:
	day_label.text = "Day %d" % [ResourceManager._current_level]
