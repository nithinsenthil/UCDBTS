extends Button

func _ready():
	#var button = $StartGameButton
	pressed.connect(_button_pressed)
	#add_child(button)

func _button_pressed():
	signals.button_click.emit()
	await get_tree().create_timer(0.1).timeout # Quick delay so click sound plays
	get_tree().quit()
