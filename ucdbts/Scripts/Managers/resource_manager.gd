extends Node

var _total_funds: int
var _pocket_value: int
var _held_item: Item
var _held_bikes: Array[Bike] = []
var _max_pocket_size: int = 5
var _pocket_full: bool = false
var _current_level: int = 1

var items_list: Array[PackedScene] = [preload("res://Scenes/Items/running_shoes.tscn"), 
		preload("res://Scenes/Items/glasses.tscn"), 
		preload("res://Scenes/Items/lockpick.tscn"),
		preload("res://Scenes/Items/bolt_cutters.tscn"),
		preload("res://Scenes/Items/chainsaw.tscn"),
		preload("res://Scenes/Items/celsius.tscn")]
var player_speed:float = 200
var stealing_speed:float = 1
var camera_zoom_factor:float = 1
var has_celsius:bool = false
var celsius:Celsius
var caught: bool = false

func get_total_funds() -> int:
	return _total_funds


func get_held_item() -> Item:    
	return _held_item



func get_current_level() -> int:
	return _current_level


func get_num_held_bikes() -> int:
	return _held_bikes.size()


func get_max_pocket_size() -> int:
	return _max_pocket_size


func add_bike(bike: Bike) -> bool:
	if bike == null:
		return false

	if _held_bikes.size() >= _max_pocket_size:
		_pocket_full = true
		var player = get_node("../level_1/Player") as Player
		if player != null:
			player.enable_pockets_full_label()

		return false
	
	_pocket_value += bike.value
	_held_bikes.append(bike.duplicate())
	if _held_bikes.size() >= _max_pocket_size:
		_pocket_full = true

	print("Bike stolen")
	var pockets_display = get_node("../level_1/PocketsDisplay") as Pockets
	if pockets_display != null:
		pockets_display.update_label()

	return true



func buy_item(item: Item) -> bool:

	if item == null or item.value > _total_funds:
		return false
	
	_total_funds -= item.value

	if item.get_item_name() == "Celsius":
		has_celsius = true
		celsius = item.duplicate()
	else:
		if _held_item != null:
			_held_item.remove_item_effect()
		_held_item = item.duplicate()
	
	item.apply_item_effect()
	
	var pockets_display = get_node("../shop/ShopMoneyLabel") as Label
	if pockets_display != null:
		pockets_display.update_label()
	

	return true


func sell_bikes() -> void:

	# Sell bikes
	_total_funds += _pocket_value
	clear_pocket()

	_pocket_full = false
	
	# Update view
	var pockets_display = get_node("../shop/ShopMoneyLabel") as Label
	if pockets_display != null:
		pockets_display.update_label()


func clear_pocket() -> void:
	_held_bikes.clear()
	_pocket_value = 0



func wipe_resources() -> void:
	_total_funds = 0

	_pocket_value = 0
	_held_item = null
	_held_bikes.clear()
	_pocket_full = false



func next_level() -> void:
	_current_level += 1



func is_pocket_full() -> bool:
	return _pocket_full


func get_pocket_value() -> int:
	return _pocket_value


func remove_celius() -> void:
	has_celsius = false
	celsius.remove_item_effect()
