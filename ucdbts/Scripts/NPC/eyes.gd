class_name Eyes
extends Sensor

const MAX_SENS: float = 1.0
const MIN_SENS: float = 0.0
const MEAN_SENS: float = 0.8
const STDEV_SENS: float = 0.1


func _ready() -> void:
	signals.player_visually_sus.connect(_on_sense)
	super()
