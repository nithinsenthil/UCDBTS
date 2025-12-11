class_name Chainsaw
extends Item

var _stealing_speed_increase:float = 0.75


func _ready() -> void:
	item_name = "Chainsaw"
	value = 1000
	texture_path = "res://Assets/items/item5_image.png"
	icon_path = "res://Assets/items/item5_icon.png"
	item_desc = "Steal bikes 75% faster"


func apply_item_effect() -> void:
	ResourceManager.stealing_speed += _stealing_speed_increase


func remove_item_effect() -> void:
	ResourceManager.stealing_speed -= _stealing_speed_increase
