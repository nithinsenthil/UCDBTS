extends Node2D

var player:Player = interactions.player


func _on_leave_shop_pressed() -> void:
	SceneManager.load_new_scene("res://Scenes/level_1.tscn", "fade_to_black")


func _on_sell_bikes_pressed() -> void:
	player.sell_bikes()
	$SellBikes.text = "Sold!"
