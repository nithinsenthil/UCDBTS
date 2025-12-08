@abstract
class_name Item
extends Node2D

@export var value: int
@export var item_name: String
@export var texture_path:String
@export var icon_path:String
@export var item_desc:String

@abstract func apply_item_effect() -> void


@abstract func remove_item_effect() -> void


func get_item_name() -> String:
	return item_name
