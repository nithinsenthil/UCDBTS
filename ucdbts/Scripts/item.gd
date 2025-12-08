@abstract
class_name Item
extends Node2D

var value: int
var item_name: String
var texture_path:String
var item_desc:String

@abstract func apply_item_effect() -> void


@abstract func remove_item_effect() -> void


func get_item_name() -> String:
	return item_name
