class_name Glasses
extends Item

var camera_zoom_factor:float = 0.5


func _ready() -> void:
	item_name  = "Glasses"
	value = 200
	texture_path = "res://Assets/items/item2_image.png"
	icon_path = "res://Assets/items/item2_icon.png"
	item_desc = "See twice as far"


func apply_item_effect() -> void:
	ResourceManager.camera_zoom_factor -= camera_zoom_factor


func remove_item_effect() -> void:
	ResourceManager.camera_zoom_factor += camera_zoom_factor
