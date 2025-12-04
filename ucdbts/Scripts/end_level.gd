extends Area2D

func _ready() -> void:
	body_entered.connect(_body_entered_trigger)
	print("Trigger Connected")
	

func _body_entered_trigger(body):
	print("Body entered")
	SceneManager.load_new_scene("res://Scenes/shop.tscn", "fade_to_black")
	queue_free()
