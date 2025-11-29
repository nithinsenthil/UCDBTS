class_name Ears
extends Sensor


func _ready() -> void:
	signals.player_audially_sus.connect(_on_sense)
	super()
