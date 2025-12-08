extends Node

var _total_funds: int
var _pocket_value: int
var _held_item: Item
var _held_bikes: Array[Bike] = []
var _max_pocket_size: int = 5
var _pocket_full: bool = false
var _current_level: int = 1

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

	print("Bike stolen")
	var pockets_display = get_node("../level_1/PocketsDisplay") as Pockets
	if pockets_display != null:
		pockets_display.update_label()

	return true


func buy_item(item: Item) -> bool:

	if item == null or item.value > _total_funds:
		return false
	
	_total_funds -= item.value
	_held_item = item.duplicate()

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
	_current_level = 1


func next_level() -> void:
	_current_level += 1


func is_pocket_full() -> bool:
	return _pocket_full


func get_pocket_value() -> int:
	return _pocket_value
