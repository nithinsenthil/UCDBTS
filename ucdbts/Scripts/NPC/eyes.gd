class_name Eyes
extends Sensor


func _ready() -> void:
	signals.player_visually_sus.connect(_on_sense)


func _on_sense(source: Vector2, strength: float) -> void:
	return
