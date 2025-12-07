class_name Money
extends Node

#var _total_funds = 0
@onready var money_label: Label = $Label


func _ready():
	# Initialize the label when the scene starts
	update_label()


func update_label():
	money_label.text = "$" + str(ResourceManager.get_total_funds())
