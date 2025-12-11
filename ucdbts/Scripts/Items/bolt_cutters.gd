class_name BoltCutters
extends Item

var _stealing_speed_increase:float = 0.3


func _ready() -> void:
	item_name = "Bolt Cutters"
	value = 400
	texture_path = "res://Assets/items/item4_image.png"
	icon_path = "res://Assets/items/item4_icon.png"
	item_desc = "Steal bikes 30%\nfaster"


func apply_item_effect() -> void:
	ResourceManager.stealing_speed += _stealing_speed_increase


func remove_item_effect() -> void:
	ResourceManager.stealing_speed -= _stealing_speed_increase
