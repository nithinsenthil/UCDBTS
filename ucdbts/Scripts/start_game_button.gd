extends Button

func _ready():
	#var button = $StartGameButton
	pressed.connect(_button_pressed)
	#add_child(button)

func _button_pressed():
	SceneManager.load_new_scene("res://Scenes/level_1.tscn", "fade_to_black")
