extends CanvasGroup


func _ready():
	if ResourceManager._current_level == 1:
		visible = true
	else:
		visible = false

func _process(_delta):
	if Input.is_action_just_pressed("ControlMenu"):
		visible = !visible
	#elif ResourceManager._current_level != 1:
		#visible = false
