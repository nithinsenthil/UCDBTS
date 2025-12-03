class_name Money
extends Node

var _total_funds = 0
@onready var money_label: Label = $Label


func _ready():
	# Initialize the label when the scene starts
	update_label()


func get_total_funds():
	return _total_funds


func buy_item(item_price):
	var remaining_funds = _total_funds - item_price
	if remaining_funds < 0:
		return false
	else:
		_total_funds -= item_price
		return true


func sell_item(item_price):
	_total_funds += item_price


func update_label():
	money_label.text = "$" + str(_total_funds)
