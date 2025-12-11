class_name Chainsaw
extends Item

var _stealing_speed_increase:float = 1


func _ready() -> void:
	item_name = "Chainsaw"
	value = 400
	texture_path = "res://Assets/items/item5_image.png"
	icon_path = "res://Assets/items/item5_icon.png"
	item_desc = "Steal bikes 100% faster"
	visual_suspicion_multiplier = 2.0
	audial_suspicion_multiplier = 4.0


func apply_item_effect() -> void:
	ResourceManager.stealing_speed += _stealing_speed_increase


func remove_item_effect() -> void:
	ResourceManager.stealing_speed -= _stealing_speed_increase
