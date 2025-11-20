@abstract
class_name Sensor
extends Node2D

var _sensitivity : float

# To be invoked on signals
@abstract func _on_sense(source: Node2D, strength: float) -> void
