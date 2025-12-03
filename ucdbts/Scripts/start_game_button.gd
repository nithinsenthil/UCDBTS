extends Button

func _ready():
	var button = $StartGameButton
	button.pressed.connect(_button_pressed)
	add_child(button)

func _button_pressed():
	print("Hello world!")
