extends Node

var _total_funds: int
var _held_item: Item
var _held_bikes: Array[Bike] = []
var _current_level: int = 1


func get_total_funds() -> int:
    return _total_funds


func get_held_item() -> Item:    
    return _held_item


func get_current_leve() -> int:
    return _current_level


func add_bike(bike: Bike) -> void:
    _held_bikes.append(bike)


func buy_item(item: Item) -> bool:

    if item == null or item.value > _total_funds:
        return false
    
    _total_funds -= item.value
    _held_item = item

    return true


func sell_bikes() -> void:
    for bike in _held_bikes:
        _total_funds += bike.value


func wipe_resources() -> void:
    _total_funds = 0
    _held_item = null
    _held_bikes = []


func next_level() -> void:
    _current_level += 1