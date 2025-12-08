class_name Chainsaw
extends Item

var _stealing_speed_increase:float = 1


func _ready() -> void:
	item_name = "Chainsaw"
	value = 400
	texture_path = "res://Assets/icon.svg"
	item_desc = "Steal bikes 100% faster"


func apply_item_effect() -> void:
	ResourceManager.stealing_speed += _stealing_speed_increase


func remove_item_effect() -> void:
	ResourceManager.stealing_speed -= _stealing_speed_increase
