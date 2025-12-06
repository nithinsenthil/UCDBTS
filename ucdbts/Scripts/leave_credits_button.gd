extends TextureButton

func _ready():
	pressed.connect(_button_pressed)

func _button_pressed():
	signals.button_click.emit()
	SceneManager.load_new_scene("res://Scenes/title.tscn", "fade_to_black")
