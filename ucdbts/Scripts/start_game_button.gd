extends TextureButton


func _ready():
	pressed.connect(_button_pressed)

func _button_pressed():
	signals.button_click.emit()
	if SceneManager.first_run:
		SceneManager.load_new_scene("res://Scenes/introduction.tscn", "fade_to_black")
	else:
		SceneManager.load_new_scene("res://Scenes/level_1.tscn", "fade_to_black")
