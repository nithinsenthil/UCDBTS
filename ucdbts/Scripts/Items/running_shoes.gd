class_name RunningShoes
extends Item

var _speed_increase:float = 50


func _ready() -> void:
	item_name = "Running Shoes"
	value = 300
	texture_path = "res://Assets/items/item1_image.png"
	icon_path = "res://Assets/items/item1_icon.png"
	item_desc = "Run 25% faster"


func apply_item_effect() -> void:
	ResourceManager.player_speed += _speed_increase


func remove_item_effect() -> void:
	ResourceManager.player_speed -= _speed_increase
