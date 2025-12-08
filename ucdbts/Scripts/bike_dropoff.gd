
class_name BikeDropoff
extends StaticBody2D

@onready var _player:Player = interactions.player


func interact() -> void:
	_player = interactions.player
	_player.sell_bikes()
	signals.interaction_done.emit()


func _on_dropoff_area_body_entered(_body: Node2D) -> void:
	interactions.current_interaction_object = self


func _on_dropoff_area_body_exited(_body: Node2D) -> void:
	signals.interaction_done.emit()
	interactions.current_interaction_object = null
