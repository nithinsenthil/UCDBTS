extends CanvasGroup


func _ready():
	visible = ResourceManager.get_current_level() == 1


func _process(_delta):
	if Input.is_action_just_pressed("ControlMenu"):
		visible = !visible
