class_name Lockpick
extends Item

var _stealing_speed_increase:float = 0.2


func _ready() -> void:
	item_name = "Lockpick"
	value = 10
	texture_path = "res://Assets/icon.svg"
	item_desc = "Steal bikes 20%\nfaster"


func apply_item_effect() -> void:
	ResourceManager.stealing_speed += _stealing_speed_increase


func remove_item_effect() -> void:
	ResourceManager.stealing_speed -= _stealing_speed_increase
