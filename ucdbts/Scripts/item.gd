@abstract
class_name Item
extends Node2D

@export var value: int
@export var item_name: String
@export var texture_path:String
@export var icon_path:String
@export var item_desc:String
@export var visual_suspicion_multiplier: float = 1.0
@export var audial_suspicion_multiplier: float = 1.0


@abstract func apply_item_effect() -> void


@abstract func remove_item_effect() -> void


func get_item_name() -> String:
	return item_name
