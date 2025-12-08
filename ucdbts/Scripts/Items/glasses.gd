class_name Glasses
extends Item

var camera_zoom_factor:float = 0.5


func _ready() -> void:
	item_name  = "Glasses"
	value = 300
	texture_path = "res://Assets/icon.svg"
	item_desc = "See 20% further"


func apply_item_effect() -> void:
	ResourceManager.camera_zoom_factor -= camera_zoom_factor


func remove_item_effect() -> void:
	ResourceManager.camera_zoom_factor += camera_zoom_factor
