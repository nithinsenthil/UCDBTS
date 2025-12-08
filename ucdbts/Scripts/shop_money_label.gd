class_name ShopMoneyLabel
extends Label

var player:Player = interactions.player


func _ready() -> void:
	text = "$%d" % [ResourceManager.get_total_funds()]


func update_label():
	text = "$%d" % [ResourceManager.get_total_funds()]
