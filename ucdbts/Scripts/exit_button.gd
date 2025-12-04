extends Button

func _ready():
	#var button = $StartGameButton
	pressed.connect(_button_pressed)
	#add_child(button)

func _button_pressed():
	get_tree().quit()
