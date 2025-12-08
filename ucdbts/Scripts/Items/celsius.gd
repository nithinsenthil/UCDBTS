class_name Celsius
extends Item

var _speed_increase:float = 20


func _ready() -> void:
	item_name = "Celsius"
	value = 50
	texture_path = "res://Assets/icon.svg"
	item_desc = "Run 10% faster during the next day"


func apply_item_effect() -> void:
	ResourceManager.player_speed += _speed_increase


func remove_item_effect() -> void:
	ResourceManager.player_speed -= _speed_increase
