extends ProgressBar

@onready var sprite:Sprite2D = %ProgressSprite


func _on_value_changed(value: float) -> void:
	var progress:float = value / max_value * 15
	sprite.frame = int(progress)
