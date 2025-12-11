extends CanvasGroup


func _ready():
	visible = SceneManager.first_run


func _process(_delta):
	if Input.is_action_just_pressed("ControlMenu"):
		visible = !visible
		SceneManager.first_run = false
